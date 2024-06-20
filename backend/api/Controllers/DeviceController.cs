using api.Models;
using api.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace api.Controllers
{
    [Route("api/device")]
    [ApiController]
    public class DeviceController : ControllerBase
    {
        private readonly IDeviceService _deviceService;

        public DeviceController( IDeviceService deviceService)
        {
            _deviceService = deviceService;
        }
        [HttpGet]
        public ActionResult<IEnumerable<DeviceDto>> GetAll()
        {
            var result = _deviceService.GetAll();

            return Ok(result);
        }
    }
}
