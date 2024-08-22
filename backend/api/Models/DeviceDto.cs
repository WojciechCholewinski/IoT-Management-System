namespace api.Models
{
    public class DeviceDto
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string NamePL { get; set; }
        public byte[] LightThemeImage { get; set; }
        public byte[] DarkThemeImage { get; set; }
        public bool IsOn { get; set; }
    }
}
