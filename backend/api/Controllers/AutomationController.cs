using api.Models;
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

    }
}
