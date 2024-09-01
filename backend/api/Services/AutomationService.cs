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
                .Include(a => a.Devices)
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
                .Include(a => a.Devices)
                .FirstOrDefault(a => a.Id == id);
            if (automation == null) return null;

            var automationDto = _mapper.Map<AutomationDetailDto>(automation);
            return automationDto;
        }


        // bez listy devices bo to dodajemy lub usuwamy w osobnych endpointach
        public bool? Update(int id, AutomationUpdateDto dto)
        {
            var automation = 
                _dbContext
                .Automations
                .Include (a => a.Devices)
                .FirstOrDefault(a => a.Id == id);
            if (automation == null) return null;

            if (dto.Name != null) automation.Name = dto.Name;
            if (dto.NamePL != null) automation.NamePL = dto.NamePL;
            if (dto.TriggerDays != null) automation.TriggerDays = dto.TriggerDays;
            if (dto.TriggerTime.HasValue)automation.TriggerTime = dto.TriggerTime.Value;
            if (dto.IsOn.HasValue)automation.IsOn = dto.IsOn.Value;

            _dbContext.SaveChanges();
            return true;
        }

        public void AddDevices(int automationId, AddDevicesToAutomationDto dto)
        {
            var automation = 
                _dbContext
                .Automations
                .Include(a => a.Devices)
                .FirstOrDefault(a => a.Id == automationId);

            if (automation == null)
            {
                return; //TODO:
            }

            var devices = _dbContext.Devices
                .Where(d => dto.DeviceIds.Contains(d.Id))
                .ToList();

            foreach (var device in devices)
            {
                if (!automation.Devices.Any(d => d.Id == device.Id))
                {
                    automation.Devices.Add(device);
                }
            }

            _dbContext.SaveChanges();
        }
        public void RemoveDevices(int automationId, RemoveDevicesFromAutomationDto dto)
        {
            var automation = 
                _dbContext
                .Automations
                .Include(a => a.Devices)
                .FirstOrDefault(a => a.Id == automationId);

            if (automation == null)
            {
                return; //TODO:
            }

            var devicesToRemove = automation.Devices
                .Where(d => dto.DeviceIds.Contains(d.Id))
                .ToList();

            foreach (var device in devicesToRemove)
            {
                automation.Devices.Remove(device);
            }

            _dbContext.SaveChanges();
        }
    }
}

