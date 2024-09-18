using api.Entities;
using api.Models;
using AutoMapper;
using Microsoft.AspNetCore.Http.HttpResults;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class AutomationService : IAutomationService
    {
        private readonly IoT_DbContext _dbContext;
        private readonly IMapper _mapper;

        public AutomationService(IoT_DbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }
        public IEnumerable<AutomationDetailDto> GetAll()
        {
            var automations =
                _dbContext
                .Automations
                .Include(a => a.CreatedBy)
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .ToList();

            var automationsDtos = _mapper.Map<List<AutomationDetailDto>>(automations);
            return automationsDtos;
        }

        public AutomationDetailDto GetById(int id)
        {
            var automation = 
                _dbContext
                .Automations
                .Include(a => a.CreatedBy)
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == id);
            if (automation == null) return null;

            var automationDto = _mapper.Map<AutomationDetailDto>(automation);
            return automationDto;
        }


        // bez listy devices bo to dodajemy lub usuwamy w osobnych endpointach
        public bool? Update(int id, AutomationUpdateDto dto)
        {
            var currentTime = TimeOnly.FromDateTime(DateTime.Now);

            var automation = 
                _dbContext
                .Automations
                .Include (a => a.DevicesToTurnOn)
                .Include (a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == id);
            if (automation == null) return null;

            if (dto.Name != null) automation.Name = dto.Name;
            if (dto.NamePL != null) automation.NamePL = dto.NamePL;
            if (dto.TriggerDays != null) automation.TriggerDays = dto.TriggerDays;
            // obsługuję tu sytuację gdy danego dnia automatyzacja się już wykonała, a user zmienia jej czas na nadchodzącą jeszcze dziś godzinę, a więc IsTriggeredToday ustawiamy na false tak aby w drodze wyjątku mogła się wykonać ponownie:
            if ((dto.TriggerTime != automation.TriggerTime)&&currentTime < dto.TriggerTime) automation.IsTriggeredToday = false;
            if (dto.TriggerTime.HasValue) automation.TriggerTime = dto.TriggerTime.Value;
            if (dto.IsOn.HasValue)automation.IsOn = dto.IsOn.Value;

            _dbContext.SaveChanges();
            return true;
        }

        public void AddDevices(int automationId, AddDevicesToAutomationDto dto)
        {
            var automation = 
                _dbContext
                .Automations
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == automationId);

            if (automation == null)
            {
                return; //TODO:
            }

            var devicesToTurnOn = _dbContext.Devices
                .Where(d => dto.DeviceToTurnOnIds.Contains(d.Id))
                .ToList();
            foreach (var device in devicesToTurnOn)
            {
                if (!automation.DevicesToTurnOn.Any(d => d.Id == device.Id))
                {
                    automation.DevicesToTurnOn.Add(device);
                }
            }

            var devicesToTurnOff = _dbContext.Devices
                .Where(d => dto.DeviceToTurnOffIds.Contains(d.Id))
                .ToList();
            foreach (var device in devicesToTurnOff)
            {
                if (!automation.DevicesToTurnOff.Any(d => d.Id == device.Id))
                {
                    automation.DevicesToTurnOff.Add(device);
                }
            }

            _dbContext.SaveChanges();
        }
        
        public void RemoveDevices(int automationId, RemoveDevicesFromAutomationDto dto)
        {
            var automation = 
                _dbContext
                .Automations
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == automationId);

            if (automation == null)
            {
                return; //TODO:
            }

            var devicesToTurnOn = _dbContext.Devices
                .Where(d => dto.DeviceToTurnOnIds.Contains(d.Id))
                .ToList();
            foreach (var device in devicesToTurnOn)
            {
                automation.DevicesToTurnOn.Remove(device);
            }

            var devicesToTurnOff = _dbContext.Devices
                .Where(d => dto.DeviceToTurnOffIds.Contains(d.Id))
                .ToList();
            foreach (var device in devicesToTurnOff)
            {
                automation.DevicesToTurnOff.Remove(device);
            }

            _dbContext.SaveChanges();
        }

        // Nowa metoda do resetowania stanu IsTriggeredToday
        public void ResetIsTriggeredTodayForAllAutomations()
        {
            var automations = _dbContext.Automations.ToList();

            foreach (var automation in automations)
            {
                automation.IsTriggeredToday = false;
            }

            _dbContext.SaveChanges();
        }
    }
}

