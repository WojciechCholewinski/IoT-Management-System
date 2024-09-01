using api.Models;
using Microsoft.AspNetCore.Mvc;

namespace api.Services
{
    public interface IDeviceService
    {
        IEnumerable<DeviceDto> GetAll();
        IEnumerable<DeviceNameDto> GetAllNames();
        bool? UpdateIsOn(int id, bool isOn);
    }
}
