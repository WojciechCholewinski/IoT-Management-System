using api.Entities;
using api.Exceptions;
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
                .FirstOrDefault(a => a.Id == id) ?? throw new NotFoundException($"Automation with id {id} not found.");

            var automationDto = _mapper.Map<AutomationDetailDto>(automation);
            return automationDto;
        }


        // bez listy devices bo to dodajemy lub usuwamy w osobnych endpointach
        public void Update(int id, AutomationUpdateDto dto)
        {
            var currentTime = TimeOnly.FromDateTime(DateTime.Now);

            var automation =
                _dbContext
                .Automations
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == id)
                ?? throw new NotFoundException($"Automation with id {id} not found.");

            if (dto.Name != null) automation.Name = dto.Name;
            if (dto.NamePL != null) automation.NamePL = dto.NamePL;
            if (dto.TriggerDays != null) automation.TriggerDays = dto.TriggerDays;
            // obsługuję tu sytuację gdy danego dnia automatyzacja się już wykonała, a user zmienia jej czas na nadchodzącą jeszcze dziś godzinę, a więc IsTriggeredToday ustawiamy na false tak aby w drodze wyjątku mogła się wykonać ponownie:
            if ((dto.TriggerTime != automation.TriggerTime) && currentTime < dto.TriggerTime) automation.IsTriggeredToday = false;
            if (dto.TriggerTime.HasValue) automation.TriggerTime = dto.TriggerTime.Value;
            if (dto.IsOn.HasValue) automation.IsOn = dto.IsOn.Value;

            _dbContext.SaveChanges();
        }

        public void AddDevices(int automationId, AddDevicesToAutomationDto dto)
        {
            var automation =
                _dbContext
                .Automations
                .Include(a => a.DevicesToTurnOn)
                .Include(a => a.DevicesToTurnOff)
                .FirstOrDefault(a => a.Id == automationId)
                ?? throw new NotFoundException($"Automation with id {automationId} not found.");

            // Walidacja urządzeń do włączania
            var notFoundDevicesToTurnOn = ValidateDevicesExist(dto.DeviceToTurnOnIds);

            // Walidacja urządzeń do wyłączania
            var notFoundDevicesToTurnOff = ValidateDevicesExist(dto.DeviceToTurnOffIds);

            // Zbieranie brakujących urządzeń i rzucenie wyjątku
            if (notFoundDevicesToTurnOn.Any() || notFoundDevicesToTurnOff.Any())
            {
                var errorMessage = string.Empty;

                if (notFoundDevicesToTurnOn.Any())
                {
                    errorMessage += $"The following devices to turn on were not found within the available devices in the database: {string.Join(", ", notFoundDevicesToTurnOn)}.\n";
                }

                if (notFoundDevicesToTurnOff.Any())
                {
                    errorMessage += $"The following devices to turn off were not found within the available devices in the database: {string.Join(", ", notFoundDevicesToTurnOff)}.\n";
                }

                throw new NotFoundException(errorMessage);
            }

            var devicesToTurnOn = _dbContext.Devices.Where(d => dto.DeviceToTurnOnIds.Contains(d.Id)).ToList();
            foreach (var device in devicesToTurnOn)
            {
                if (!automation.DevicesToTurnOn.Any(d => d.Id == device.Id))
                {
                    automation.DevicesToTurnOn.Add(device);
                }
            }

            var devicesToTurnOff = _dbContext.Devices.Where(d => dto.DeviceToTurnOffIds.Contains(d.Id)).ToList();
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
                .FirstOrDefault(a => a.Id == automationId)
                ?? throw new NotFoundException($"Automation with id {automationId} not found.");

            // Walidacja urządzeń do usunięcia z listy włączania
            var notFoundDevicesToTurnOn = ValidateDevicesExist(dto.DeviceToTurnOnIds);

            // Walidacja urządzeń do usunięcia z listy wyłączania
            var notFoundDevicesToTurnOff = ValidateDevicesExist(dto.DeviceToTurnOffIds);

            // Zbieranie brakujących urządzeń i rzucenie wyjątku
            if (notFoundDevicesToTurnOn.Any() || notFoundDevicesToTurnOff.Any())
            {
                var errorMessage = string.Empty;

                if (notFoundDevicesToTurnOn.Any())
                {
                    errorMessage += $"The following devices to remove from turn on list were not found within the available devices in the database: {string.Join(", ", notFoundDevicesToTurnOn)}.\n";
                }

                if (notFoundDevicesToTurnOff.Any())
                {
                    errorMessage += $"The following devices to remove from turn off list were not found within the available devices in the database: {string.Join(", ", notFoundDevicesToTurnOff)}.\n";
                }

                throw new NotFoundException(errorMessage);
            }

            var devicesToTurnOn = _dbContext.Devices.Where(d => dto.DeviceToTurnOnIds.Contains(d.Id)).ToList();
            foreach (var device in devicesToTurnOn)
            {
                automation.DevicesToTurnOn.Remove(device);
            }

            var devicesToTurnOff = _dbContext.Devices.Where(d => dto.DeviceToTurnOffIds.Contains(d.Id)).ToList();
            foreach (var device in devicesToTurnOff)
            {
                automation.DevicesToTurnOff.Remove(device);
            }
            _dbContext.SaveChanges();
        }

        // Metoda do resetowania stanu IsTriggeredToday
        public void ResetIsTriggeredTodayForAllAutomations()
        {
            var automations = _dbContext.Automations.ToList();

            foreach (var automation in automations)
            {
                automation.IsTriggeredToday = false;
            }

            _dbContext.SaveChanges();
        }

        // Metoda do sprawdzania czy wybrane urządzenia istnieją w bazie
        private List<int> ValidateDevicesExist(IEnumerable<int> deviceIds)
        {
            var existingDevices = _dbContext.Devices
                .Where(d => deviceIds.Contains(d.Id))
                .Select(d => d.Id)
                .ToList();

            var notFoundDevices = deviceIds.Except(existingDevices).ToList();

            return notFoundDevices;
        }

    }
}

