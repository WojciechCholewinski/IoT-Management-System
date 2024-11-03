namespace api.Services
{
    public interface IAdvancedDeviceService : IDeviceService
    {
        Task PerformAdvancedOperation(int id);  // TODO: przykładowa metoda specyficzna dla AdvancedDevice
    }
}
