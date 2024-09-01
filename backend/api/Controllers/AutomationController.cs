﻿using api.Models;
using api.Services;
using Microsoft.AspNetCore.Mvc;

namespace api.Controllers
{
    [Route("api/automation")]
    [ApiController]
    public class AutomationController : ControllerBase
    {
        private readonly IAutomationService _automationService;

        public AutomationController(IAutomationService automationService)
        {
            _automationService = automationService;
        }

        [HttpGet]
        public ActionResult<IEnumerable<AutomationDetailDto>> GetAll()
        {
            var result = _automationService.GetAll();

            return Ok(result);
        }

        [HttpGet("{id}")]
        public ActionResult<IEnumerable<AutomationDetailDto>> GetById(int id) 
        { 
            var automationDto = _automationService.GetById(id);
            return Ok(automationDto);
        }

        [HttpPut("{id}")]
        public IActionResult Update([FromRoute] int id, [FromBody] AutomationUpdateDto dto)
        {
            var result = _automationService.Update(id, dto);

            if (result == null) return NotFound(new { message = "Automation not found" });

            if (result == false) return Conflict(new { message = "Automation is already in the requested state" });

            return Ok(new { message = "Automation state updated successfully" });
        }

        [HttpPost("{Automationid}/devices")]
        public IActionResult AddDevices([FromRoute] int Automationid, [FromBody] AddDevicesToAutomationDto dto)
        { 
            _automationService.AddDevices(Automationid, dto);
            return Ok();
        }

        [HttpDelete("{Automationid}/devices")]
        public ActionResult RemoveDevices([FromRoute] int Automationid, [FromBody] RemoveDevicesFromAutomationDto dto)
        {
            _automationService.RemoveDevices(Automationid, dto);
            return NoContent();
        }

    }
}
