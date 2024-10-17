using api.Models;

namespace api.Services
{
    public interface IDeviceService
    {
        IEnumerable<DeviceDto> GetAll();
        IEnumerable<DeviceNameDto> GetAllNames();
        void UpdateIsOn(int id, bool isOn);
    }
}
