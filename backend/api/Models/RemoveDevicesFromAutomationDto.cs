﻿namespace api.Models
{
    public class RemoveDevicesFromAutomationDto
    {
        public List<int>? DeviceToTurnOnIds { get; set; }
        public List<int>? DeviceToTurnOffIds { get; set; }
    }
}
