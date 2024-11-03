using api.Entities;
using api.Exceptions;
using AutoMapper;

namespace api.Services
{
    public class AdvancedDeviceService : DeviceService, IAdvancedDeviceService
    {
        private readonly IAdvancedDeviceHandler _advancedDeviceHandler;

        public AdvancedDeviceService(IoT_DbContext dbContext, IMapper mapper, IMqttService mqttService, IAdvancedDeviceHandler advancedDeviceHandler)
            : base(dbContext, mapper, mqttService)
        {
            _advancedDeviceHandler = advancedDeviceHandler;
        }

        public override async Task UpdateIsOn(int id, bool isOn)
        {
            // Wywołaj podstawową logikę DeviceService
            await base.UpdateIsOn(id, isOn);

            // Specyficzna logika dla AdvancedDevice
            var device =
                _dbContext
                .Devices
                .OfType<AdvancedDevice>()
                .FirstOrDefault(d => d.Id == id);
            if (device != null)
            {
                await _advancedDeviceHandler.HandleAdvancedDeviceLogic(device, isOn);
                await _dbContext.SaveChangesAsync();
            }
        }

        public async Task PerformAdvancedOperation(int id) // TODO: przykładowa implementacja metody specyficznej dla AdvancedDevice
        {
            var device =
                _dbContext
                .Devices.OfType<AdvancedDevice>()
                .FirstOrDefault(d => d.Id == id)
                ?? throw new NotFoundException($"Advanced device with id {id} not found.");

            await _advancedDeviceHandler.PerformSpecificOperation(device);
        }
    }

}
