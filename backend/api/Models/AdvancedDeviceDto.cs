namespace api.Models
{
    public class AdvancedDeviceDto : DeviceDto
    {
        public long RealRuntimeTicks { get; set; }
        public TimeSpan TimeOfWork { get; set; }
    }
}
