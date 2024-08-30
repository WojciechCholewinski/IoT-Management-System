using api.Entities;
using api.Models;
using AutoMapper;

namespace api
{
    public class IoT_MappingProfile : Profile
    {
        public IoT_MappingProfile()
        {
            CreateMap<Device, DeviceDto>();
            CreateMap<Automation, AutomationDetailDto>()
                .ForMember(m => m.CreatedByEmail, c => c.MapFrom(s => s.CreatedBy.Email));
            CreateMap<Device, DeviceNameDto>();

        }
    }
}
