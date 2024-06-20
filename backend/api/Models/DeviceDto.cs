namespace api.Models
{
    public class DeviceDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public bool IsOn { get; set; }
    }
}
