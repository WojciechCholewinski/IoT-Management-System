using Common.Entities;

namespace Common.Services
{
    public interface IAdvancedDeviceHandler
    {
        Task HandleAdvancedDeviceLogic(AdvancedDevice device, bool isOn);
        Task PerformSpecificOperation(AdvancedDevice device);  // TODO: przykładowa metoda specyficzna dla AdvancedDevice
    }
}
