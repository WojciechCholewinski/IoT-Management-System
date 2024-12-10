using Common.Services;
using Microsoft.Azure.Functions.Worker;

namespace DailyResetFunction
{
    public class ResetFunction
    {
        private readonly IAutomationService _automationService;

        public ResetFunction(IAutomationService automationService)
        {
            _automationService = automationService;
        }

        [Function("DailyResetFunction")]
        public void Run([TimerTrigger("0 0 0 * * *")] TimerInfo myTimer)
        {
            ResetAutomationsAtMidnight();
        }

        private void ResetAutomationsAtMidnight()
        {
            _automationService.ResetIsTriggeredTodayForAllAutomations();
        }
    }
}
