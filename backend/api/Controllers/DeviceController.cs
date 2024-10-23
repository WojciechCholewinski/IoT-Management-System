using api.Models;
using api.Services;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/device")]
    [ApiController]
    public class DeviceController : ControllerBase
    {
        private readonly IDeviceService _deviceService;

        public DeviceController(IDeviceService deviceService)
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
        public async Task<IActionResult> UpdateIsOn(int id, [FromBody] bool isOn)
        {
            await _deviceService.UpdateIsOn(id, isOn);
            return Ok(new { message = "Device state updated successfully", updatedState = isOn });
        }
    }
}
