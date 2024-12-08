using Common.Services;
using Microsoft.Azure.Functions.Worker;

namespace AutomationTriggerFunction
{
    public class TriggerFunction
    {
        private readonly IDeviceService _deviceService;
        public TriggerFunction(IDeviceService deviceService)
        {
            _deviceService = deviceService;
        }

        [Function("AutomationTriggerFunction")]
        public async Task Run([TimerTrigger("0 * * * * *")] TimerInfo myTimer)
        {
            await _deviceService.DoWorkAsync();
        }        
    }
}
