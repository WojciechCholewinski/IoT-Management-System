namespace Common.DTOs
{
    public class AdvancedDeviceDto : DeviceDto
    {
        public long RealRuntimeTicks { get; set; }
        public TimeSpan TimeOfWork { get; set; }
    }
}
