namespace api.Models
{
    public class AutomationSummaryDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string NamePL { get; set; }
        public required byte[] Image { get; set; }
        public bool IsOn { get; set; }

    }
}
