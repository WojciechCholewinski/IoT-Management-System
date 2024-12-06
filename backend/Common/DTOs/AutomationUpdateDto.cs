namespace Common.DTOs
{
    public class AutomationUpdateDto
    {
        public string? Name { get; set; }
        public string? NamePL { get; set; }
        public IList<DayOfWeek>? TriggerDays { get; set; }
        public TimeOnly? TriggerTime { get; set; }
        public bool? IsOn { get; set; }
    }
}
