using Common.Entities;

namespace Common.Services
{
    public class AdvancedDeviceHandler : IAdvancedDeviceHandler
    {
        public async Task HandleAdvancedDeviceLogic(AdvancedDevice device, bool isOn)
        {
            if (device.LastTrigger.HasValue && !isOn)
            {
                var now = DateTime.Now;
                var timeSpan = now - device.LastTrigger.Value;
                device.RealRuntimeTicks += (long)timeSpan.Ticks;
            }
            device.LastTrigger = DateTime.Now;
        }

        public async Task PerformSpecificOperation(AdvancedDevice device)
        {
            // TODO: Implementacja operacji specyficznej dla Advanced  
        }
    }
}
