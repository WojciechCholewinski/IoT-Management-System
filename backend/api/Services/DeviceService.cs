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

        public bool? UpdateIsOn(int id, bool isOn)
        {
            var device = 
                _dbContext
                .Devices
                .FirstOrDefault(d => d.Id == id);

            if (device == null)
            {
                return null;
            }
            if (device.IsOn == isOn) 
            {
                return false;
            }
            if (device.LastUpdate.HasValue && !isOn)
            {
                var timeSpan = DateTime.Now - device.LastUpdate.Value;
                device.RunTime += timeSpan;
            }
            device.IsOn = isOn;
            device.LastUpdate = DateTime.Now;

            _dbContext.SaveChanges();
            return true;
        }
    }
}
