using api.Entities;
using System.Data;
using System.Net;
using System.Reflection;

namespace api
{
    public class ApiSeeder
    {
        IoT_DbContext _dbContext;
        private readonly string _imagesPath;

        public ApiSeeder(IoT_DbContext dbContext, IConfiguration configuration)
        {
            _dbContext = dbContext;
            _imagesPath = configuration["ImagesPath"];
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
                CreateDevice("Desk Lighting", myRoom),
                CreateDevice("Hallway Lighting", hallway),
                CreateDevice("Under Lighting", myRoom),
                CreateDevice("Kitchen Lighting", kitchen),
                CreateDevice("Drawer Lock", myRoom),
                CreateDevice("Roller Blinds - W", myRoom),
                CreateDevice("Roller Blinds - M", smallRoom),
                CreateDevice("Roller Blinds - D", livingRoom),
                CreateDevice("Air Conditioner", myRoom),
                CreateDevice("Air Purifier", myRoom),
                CreateDevice("Soil Moisture Sensor", livingRoom),
                CreateDevice("Temperature Sensor", livingRoom)
            };
            return devices;
        }

        private Device CreateDevice(string name, LocationType location)
        {
            return new Device
            {
                Name = name,
                Location = location,
                LightThemeImage = LoadImage($"{name.Replace(" ", "_")}_-_Light_mode.png"),
                DarkThemeImage = LoadImage($"{name.Replace(" ", "_")}_-_Dark_mode.png")
            };
        }

        private byte[] LoadImage(string fileName)
        {
            var filePath = Path.Combine(_imagesPath, fileName);

            if (File.Exists(filePath))
            {
                return File.ReadAllBytes(filePath);
            }
            else
            {
                return null;
            }
        }
    }
}
