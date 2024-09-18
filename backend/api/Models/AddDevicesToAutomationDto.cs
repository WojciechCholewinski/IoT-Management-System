namespace api.Models
{
    public class AddDevicesToAutomationDto
    {
        public List<int>? DeviceToTurnOnIds { get; set; }
        public List<int>? DeviceToTurnOffIds { get; set; }
    }
}
