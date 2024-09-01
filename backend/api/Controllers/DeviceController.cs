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

        [HttpGet("name")]
        public ActionResult<IEnumerable<DeviceNameDto>> GetAllNames()
        {
            var result = _deviceService.GetAllNames();

            return Ok(result);
        }

        [HttpPatch("{id}/ison")]
        public IActionResult UpdateIsOn(int id, [FromBody] bool isOn)
        {
            var result = _deviceService.UpdateIsOn(id, isOn);

            if (result == null) return NotFound(new { message = "Device not found" });
            
            if (result == false) return Conflict(new { message = "Device is already in the requested state" });
            
            return Ok(new { message = "Device state updated successfully", updatedState = isOn });
        }
    }
}
