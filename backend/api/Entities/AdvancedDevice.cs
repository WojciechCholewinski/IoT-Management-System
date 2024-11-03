namespace api.Entities
{
    public class AdvancedDevice : Device
    {
        public long RealRuntimeTicks { get; set; }
        public TimeSpan TimeOfWork { get; set; }
        public DateTime? LastTrigger { get; set; }
    }
}
