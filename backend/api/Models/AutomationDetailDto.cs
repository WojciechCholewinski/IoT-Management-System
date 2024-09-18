using api.Entities;
using System.Text.Json.Serialization;

namespace api.Models
{
    public class AutomationDetailDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string NamePL { get; set; }
        public required byte[] Image { get; set; }
        public required IList<DayOfWeek> TriggerDays { get; set; }
        public required TimeOnly TriggerTime { get; set; }
        public bool IsOn { get; set; }
        public string CreatedByEmail { get; set; }
        public List<DeviceNameDto> DevicesToTurnOn { get; set; }
        public List<DeviceNameDto> DevicesToTurnOff { get; set; }

    }
}
