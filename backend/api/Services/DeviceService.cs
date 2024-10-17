using api.Entities;
using api.Exceptions;
using api.Models;
using AutoMapper;

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

        public IEnumerable<DeviceNameDto> GetAllNames()
        {
            var devices =
                _dbContext
                .Devices
                .ToList();

            var devicesDtos = _mapper.Map<List<DeviceNameDto>>(devices);
            return devicesDtos;
        }

        public void UpdateIsOn(int id, bool isOn)
        {
            var now = DateTime.Now;

            var device =
                _dbContext
                .Devices
                .FirstOrDefault(d => d.Id == id)
                ?? throw new NotFoundException($"Device with id {id} not found.");

            if (device.IsOn == isOn)
                throw new ConflictException($"Device with id {id} is already in the requested state.");

            if (device.LastUpdate.HasValue && !isOn)
            {
                var timeSpan = now - device.LastUpdate.Value;
                device.RunTimeTicks += (long)timeSpan.TotalMilliseconds;
            }
            device.IsOn = isOn;
            device.LastUpdate = now;

            _dbContext.SaveChanges();
        }
    }
}
