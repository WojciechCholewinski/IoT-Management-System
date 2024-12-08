using Common.DTOs;

namespace Common.Services
{
    public interface IDeviceService
    {
        IEnumerable<object> GetAll();
        IEnumerable<DeviceNameDto> GetAllNames();
        Task UpdateIsOn(int id, bool isOn);
        Task DoWorkAsync();
    }
}
