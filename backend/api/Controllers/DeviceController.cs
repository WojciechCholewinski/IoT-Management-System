using Common.DTOs;
using Common.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    /// <summary>
    /// Controller responsible for managing devices within the system.
    /// Provides endpoints for retrieving device details, names, and updating their state.
    /// All actions require user authentication.
    /// </summary>
    [Route("api/device")]
    [ApiController]
    public class DeviceController : ControllerBase
    {
        private readonly IDeviceService _deviceService;

        public DeviceController(IDeviceService deviceService)
        {
            _deviceService = deviceService;
        }

        /// <summary>
        /// Retrieves all devices available in the system along with their details.
        /// </summary>
        /// <response code="200">(OK)               Returned when the devices data has been successfully retrieved.</response>
        /// <response code="401">(Unauthorized)     Returned when the user is not authenticated.</response>
        [Authorize]
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public ActionResult<IEnumerable<object>> GetAll()
        {
            var result = _deviceService.GetAll();
            return Ok(result);
        }

        /// <summary>
        /// Retrieves only the names of all devices available in the system.
        /// </summary>
        /// <response code="200">(OK)               Returned when the device names has been successfully retrieved.</response>
        /// <response code="401">(Unauthorized)     Returned when the user is not authenticated.</response>
        [Authorize]
        [HttpGet("name")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public ActionResult<IEnumerable<DeviceNameDto>> GetAllNames()
        {
            var result = _deviceService.GetAllNames();
            return Ok(result);
        }

        /// <summary>
        /// Toggles (enables or disables) the specified device.
        /// </summary>
        /// <param name="id">The ID of the device to update.</param>
        /// <param name="isOn">The desired state of the device (true for ON, false for OFF).</param>
        /// <response code="200">(OK)               Returned when the device state has been successfully updated (ON/OFF).</response>
        /// <response code="401">(Unauthorized)     Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)         Returned when a device with the specified ID is not found.</response>
        /// <response code="409">(Conflict)         Returned when the device is already in the requested state.</response>
        /// <response code="503">(ServiceUnavailable)Returned when the MQTT message to update the device state could not be published. </response>
        [Authorize]
        [HttpPatch("{id}/ison")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status409Conflict)]
        [ProducesResponseType(StatusCodes.Status503ServiceUnavailable)]
        public async Task<IActionResult> UpdateIsOn(int id, [FromBody] bool isOn)
        {
            await _deviceService.UpdateIsOn(id, isOn);
            return Ok(new { message = "Device state updated successfully", updatedState = isOn });
        }
    }
}
