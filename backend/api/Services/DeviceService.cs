using api.Entities;
using api.Exceptions;
using api.Models;
using AutoMapper;

namespace api.Services
{
    public class DeviceService : IDeviceService
    {
        private readonly IoT_DbContext _dbContext;
        private readonly IMapper _mapper;
        private readonly IMqttService _mqttService;

        public DeviceService(IoT_DbContext dbContext, IMapper mapper, IMqttService mqttService)
        {
            _dbContext = dbContext;
            _mapper = mapper;
            _mqttService = mqttService;
        }
        public IEnumerable<DeviceDto> GetAll()
        {
            var devices =
                _dbContext
                .Devices
                .ToList();

            var devicesDtos = _mapper.Map<List<DeviceDto>>(devices);
            return devicesDtos;
        }

        public IEnumerable<DeviceNameDto> GetAllNames()
        {
            var devices =
                _dbContext
                .Devices
                .ToList();

            var devicesDtos = _mapper.Map<List<DeviceNameDto>>(devices);
            return devicesDtos;
        }

        public async Task UpdateIsOn(int id, bool isOn)
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
                device.RunTimeTicks += (long)timeSpan.TotalMilliseconds;
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
