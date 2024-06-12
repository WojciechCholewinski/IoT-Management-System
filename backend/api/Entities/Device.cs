namespace api.Entities
{
    public class Device
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public LocationType? Location { get; set; }
        public bool IsOn { get; set; }
        public DateTime? LastUpdate { get; set; }
        public TimeSpan RunTime { get; set; }
    }
}

