using Common.DTOs;
using Common.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    /// <summary>
    /// Controller responsible for managing automations that control devices within the system.
    /// Provides endpoints for retrieving automation details, updating them, and managing associated devices,
    /// by adding devices to, or removing them from, the automation's assigned devices lists.
    /// All actions require user authentication.
    /// </summary>
    [Route("api/automation")]
    [ApiController]
    public class AutomationController : ControllerBase
    {
        private readonly IAutomationService _automationService;

        public AutomationController(IAutomationService automationService)
        {
            _automationService = automationService;
        }

        /// <summary>
        /// Retrieves all automations available in the system.
        /// </summary>
        /// <response code="200">(OK)           Returned when the automations data has been successfully retrieved.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        [Authorize]
        [HttpGet]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public ActionResult<IEnumerable<AutomationDetailDto>> GetAll()
        {
            var result = _automationService.GetAll();
            return Ok(result);
        }

        /// <summary>
        /// Retrieves the details of an automation by its ID.
        /// </summary>
        /// <response code="200">(OK)           Returned when the automation details are successfully retrieved. </response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when the automation with the given ID was not found.</response>
        [Authorize]
        [HttpGet("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<AutomationDetailDto> GetById(int id)
        {
            var automationDto = _automationService.GetById(id);
            return Ok(automationDto);
        }

        /// <summary>
        /// Updates the details of a specific automation, excluding the management of associated devices.
        /// </summary>
        /// <response code="200">(OK)           Returned when the automation details are successfully updated. </response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when the automation with the given ID was not found.</response>
        [Authorize]
        [HttpPut("{id}")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult Update([FromRoute] int id, [FromBody] AutomationUpdateDto dto)
        {
            _automationService.Update(id, dto);
            return Ok(new { message = "Automation state updated successfully" });
        }

        /// <summary>
        /// Adds devices to the lists of devices to turn on and turn off for an automation.
        /// </summary>
        /// <response code="200">(OK)           Returned when the device lists are successfully updated. </response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when either the automation or one or more devices with the given IDs are not found in the database. </response>
        [Authorize]
        [HttpPost("{Automationid}/devices")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public IActionResult AddDevices([FromRoute] int Automationid, [FromBody] AddDevicesToAutomationDto dto)
        {
            _automationService.AddDevices(Automationid, dto);
            return Ok();
        }

        /// <summary>
        /// Removes devices from the lists of devices to turn on and turn off for an automation.
        /// </summary>
        /// <response code="204">(NoContent)    Returned when the device lists are successfully updated.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when either the automation or one or more devices with the given IDs are not found in the database. </response>
        [Authorize]
        [HttpDelete("{Automationid}/devices")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult RemoveDevices([FromRoute] int Automationid, [FromBody] RemoveDevicesFromAutomationDto dto)
        {
            _automationService.RemoveDevices(Automationid, dto);
            return NoContent();
        }

    }
}
