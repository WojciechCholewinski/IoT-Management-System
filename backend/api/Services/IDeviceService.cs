using api.Models;
using Microsoft.AspNetCore.Mvc;

namespace api.Services
{
    public interface IDeviceService
    {
        public ActionResult<IEnumerable<DeviceDto>> GetAll();
    }
}
