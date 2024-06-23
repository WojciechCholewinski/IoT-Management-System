using api.Entities;
using api.Models;
using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class DeviceService : IDeviceService
    {
        private readonly IoT_DbContext _dbContext;
        private readonly IMapper _mapper;

        public DeviceService(IoT_DbContext dbContext, IMapper mapper)
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }
        public IEnumerable<DeviceDto> GetAll()
        {
            var devices = 
                _dbContext
                .Devices
                .ToList();

            var devicesDtos = _mapper.Map<List<DeviceDto>>(devices);
            return devicesDtos;
        }
    }
}
