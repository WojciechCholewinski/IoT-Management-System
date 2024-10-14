namespace api.Entities
{
    public class Device
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string NamePL { get; set; }
        public required byte[] LightThemeImage { get; set; }
        public required byte[] DarkThemeImage { get; set; }
        public LocationType? Location { get; set; }
        public bool IsOn { get; set; }
        public DateTime? LastUpdate { get; set; }
        public long RunTimeTicks { get; set; }

        // Automatyzacje, w których urządzenie jest włączane
        public ICollection<Automation>? AutomationsToTurnOn { get; set; }

        // Automatyzacje, w których urządzenie jest wyłączane
        public ICollection<Automation>? AutomationsToTurnOff { get; set; }
    }
}

