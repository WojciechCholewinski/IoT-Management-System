using api.Models;

namespace api.Services
{
    public interface IDeviceService
    {
        IEnumerable<object> GetAll();
        IEnumerable<DeviceNameDto> GetAllNames();
        Task UpdateIsOn(int id, bool isOn);
    }
}
