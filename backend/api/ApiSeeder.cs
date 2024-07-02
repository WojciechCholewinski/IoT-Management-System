using api.Entities;
using System.Data;
using System.Net;

namespace api
{
    public class ApiSeeder
    {
        IoT_DbContext _dbContext;

        public ApiSeeder(IoT_DbContext dbContext)
        {
            _dbContext = dbContext;
        }
        public void Seed()
        {
            if (_dbContext.Database.CanConnect())
            {
                if (!_dbContext.Roles.Any())
                {
                    var roles = GetRoles();
                    _dbContext.Roles.AddRange(roles);

                    _dbContext.SaveChanges();
                }

                if (!_dbContext.Devices.Any())
                {
                    SeedLocations();

                    var devices = GetDevices();
                    _dbContext.Devices.AddRange(devices);

                    _dbContext.SaveChanges();
                }
            }
        }

        private void SeedLocations()
        {
            if (!_dbContext.LocationTypes.Any())
            {
                var locations = new List<LocationType>()
                {
                    new LocationType() { Name = "My room" },
                    new LocationType() { Name = "Hallway" },
                    new LocationType() { Name = "Kitchen" },
                    new LocationType() { Name = "Small room" },
                    new LocationType() { Name = "Living room" }
                };

                _dbContext.LocationTypes.AddRange(locations);
                _dbContext.SaveChanges();
            }
        }

        private IEnumerable<Role> GetRoles()
        {
            var roles = new List<Role>()
            {
                new Role { Name = "Admin" },
                new Role { Name = "User" }
            };
            return roles; 
        }
        private IEnumerable<Device> GetDevices()
        {
            var myRoom = _dbContext.LocationTypes.FirstOrDefault(l => l.Name == "My room");
            var hallway = _dbContext.LocationTypes.FirstOrDefault(l => l.Name == "Hallway");
            var kitchen = _dbContext.LocationTypes.FirstOrDefault(l => l.Name == "Kitchen");
            var smallRoom = _dbContext.LocationTypes.FirstOrDefault(l => l.Name == "Small room");
            var livingRoom = _dbContext.LocationTypes.FirstOrDefault(l => l.Name == "Living room");

            var devices = new List<Device>()
            {
                new Device() { Name = "Desk Lighting", Location = myRoom },
                new Device() { Name = "Hallway Lighting", Location = hallway },
                new Device() { Name = "Under Lighting", Location = myRoom },
                new Device() { Name = "Kitchen Lighting", Location = kitchen },
                new Device() { Name = "Drawer Lock", Location = myRoom },
                new Device() { Name = "Roller Blinds - W", Location = myRoom },
                new Device() { Name = "Roller Blinds - M", Location = smallRoom },
                new Device() { Name = "Roller Blinds - D", Location = livingRoom },
                new Device() { Name = "Air Conditioner", Location = myRoom },
                new Device() { Name = "Air Purifier", Location = myRoom },
                new Device() { Name = "Soil Moisture Sensor", Location = livingRoom },
                new Device() { Name = "Temperature Sensor", Location = livingRoom }
            };
            return devices;
        }
    }
}
