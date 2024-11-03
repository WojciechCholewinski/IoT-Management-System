using api.Entities;
using api.Models;
using AutoMapper;

namespace api
{
    public class IoT_MappingProfile : Profile
    {
        public IoT_MappingProfile()
        {
            CreateMap<Device, DeviceDto>()
                .ForMember(dest => dest.RunTime, opt => opt.MapFrom(src => TimeSpan.FromTicks(src.RunTimeTicks)));
            CreateMap<AdvancedDevice, AdvancedDeviceDto>()
                .ForMember(dest => dest.RunTime, opt => opt.MapFrom(src => TimeSpan.FromTicks(src.RealRuntimeTicks)));
            CreateMap<Automation, AutomationDetailDto>()
                .ForMember(m => m.CreatedByEmail, c => c.MapFrom(s => s.CreatedBy.Email))
                .ForMember(m => m.DevicesToTurnOn, c => c.MapFrom(s => s.DevicesToTurnOn))
                .ForMember(m => m.DevicesToTurnOff, c => c.MapFrom(s => s.DevicesToTurnOff));
            CreateMap<Automation, AutomationUpdateDto>();
            CreateMap<Device, DeviceNameDto>();
            CreateMap<DeviceNameDto, Device>();
            CreateMap<User, GetUserDto>();
        }
    }
}
