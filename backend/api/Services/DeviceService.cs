using api.Entities;
using api.Exceptions;
using api.Models;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class DeviceService : IDeviceService
    {
        protected readonly IoT_DbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IMqttService _mqttService;

        public DeviceService(IoT_DbContext dbContext, IMapper mapper, IMqttService mqttService)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _mqttService = mqttService;
        }
        public IEnumerable<object> GetAll()
        {
            // Pobierz standardowe urządzenia i zamapuj je na DeviceDto
            var standardDevices =
                _dbContext
                .Devices
                .Where(d => EF.Property<string>(d, "DeviceType") == "StandardDevice") // Pobiera tylko standardowe urządzenia
                .Select(d => _mapper.Map<DeviceDto>(d))
                .ToList();

            // Pobierz zaawansowane urządzenia i zamapuj je na AdvancedDeviceDto
            var advancedDevices =
                _dbContext
                .Devices
                .OfType<AdvancedDevice>() // Pobiera tylko zaawansowane urządzenia
                .Select(ad => _mapper.Map<AdvancedDeviceDto>(ad))
                .ToList();

            // Połącz obie listy, posortuj po id i zwróć
            var allDevices = standardDevices.Cast<object>()
                .Concat(advancedDevices)
                .OrderBy(d => ((DeviceDto)d).Id) // Sortowanie po Id
                .ToList();

            return allDevices;

        }

        public IEnumerable<DeviceNameDto> GetAllNames()
        {
            var devices =
                _dbContext
                .Devices
                .ToList();

            var devicesDtos = _mapper.Map<List<DeviceNameDto>>(devices);
            return devicesDtos;
            // TODO: ew jak wyżej jeśli będziemy zwracać też w UI rodzaj device
        }

        public virtual async Task UpdateIsOn(int id, bool isOn)
        {
            var now = DateTime.Now;

            var device =
                _dbContext
                .Devices
                .FirstOrDefault(d => d.Id == id)
                ?? throw new NotFoundException($"Device with id {id} not found.");

            if (device.IsOn == isOn)
                throw new ConflictException($"Device with id {id} is already in the requested state.");

            if (device.LastUpdate.HasValue && !isOn)
            {
                var timeSpan = now - device.LastUpdate.Value;
                device.RunTimeTicks += (long)timeSpan.Ticks;
            }

            var topic = $"devices/{device.Id}/status";
            var message = isOn ? "ON" : "OFF";

            try
            {
                await _mqttService.PublishMessageAsync(topic, message);
            }
            catch (Exception)
            {
                throw new MqttException($"Failed to publish MQTT message for device {device.Name} (id={device.Id}) on topic {topic}.");
            }

            device.IsOn = isOn;
            device.LastUpdate = now;

            await _dbContext.SaveChangesAsync();
        }
    }
}
