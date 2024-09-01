﻿namespace api.Entities
{
    public class Automation
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string NamePL { get; set; }
        public required byte[] Image { get; set; }
        public required IList<DayOfWeek> TriggerDays { get; set; }
        public required TimeOnly TriggerTime { get; set; }
        public bool IsOn { get; set; }
        public required User CreatedBy { get; set; }
        public required IList<Device> Devices { get; set; }
    }
}