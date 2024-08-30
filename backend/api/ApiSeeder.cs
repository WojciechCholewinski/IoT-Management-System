using api.Entities;
using System.Collections;
using System.Collections.Generic;
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

                    if (!_dbContext.Automations.Any())
                    {
                        var automations = GetAutomations();
                        _dbContext.Automations.AddRange(automations);

                        _dbContext.SaveChanges();
                    }
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
                CreateDevice("Desk Lighting", "Oświetlenie biurka", myRoom),
                CreateDevice("Hallway Lighting", "Oświetlenie korytarza", hallway),
                CreateDevice("Under Lighting", "Podświetlenie", myRoom),
                CreateDevice("Kitchen Lighting", "Oświetlenie kuchni", kitchen),
                CreateDevice("Drawer Lock", "Zamek szuflady", myRoom),
                CreateDevice("Roller Blinds - W", "Rolety - W", myRoom),
                CreateDevice("Roller Blinds - M", "Rolety - M", smallRoom),
                CreateDevice("Roller Blinds - D", "Rolety - D", livingRoom),
                CreateDevice("Air Conditioner", "Klimatyzator", myRoom),
                CreateDevice("Air Purifier", "Oczyszczacz powietrza", myRoom),
                CreateDevice("Soil Moisture Sensor", "Czujnik wilgotności gleby", livingRoom),
                CreateDevice("Temperature Sensor", "Czujnik temperatury", livingRoom)
            };
            return devices;
        }

        private Device CreateDevice(string name, string namePL, LocationType location)
        {
            return new Device
            {
                Name = name,
                NamePL = namePL,
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

        private IEnumerable<Automation> GetAutomations()
        {
            var creator = _dbContext.Users.FirstOrDefault(u => u.Email == "t@test.com");

            var allDevices = _dbContext.Devices.ToList();

            var DeskLighting = allDevices.FirstOrDefault(d => d.Name == "Desk Lighting");
            var HallwayLighting = allDevices.FirstOrDefault(d => d.Name == "Hallway Lighting");
            var UnderLighting = allDevices.FirstOrDefault(d => d.Name == "Under Lighting");
            var KitchenLighting = allDevices.FirstOrDefault(d => d.Name == "Kitchen Lighting");
            var DrawerLock = allDevices.FirstOrDefault(d => d.Name == "Drawer Lock");
            var RollerBlindsW = allDevices.FirstOrDefault(d => d.Name == "Roller Blinds - W");
            var RollerBlindsM = allDevices.FirstOrDefault(d => d.Name == "Roller Blinds - M");
            var RollerBlindsD = allDevices.FirstOrDefault(d => d.Name == "Roller Blinds - D");
            var AirConditioner = allDevices.FirstOrDefault(d => d.Name == "Air Conditioner");
            var AirPurifier = allDevices.FirstOrDefault(d => d.Name == "Air Purifier");
            var SoilMoistureSensor = allDevices.FirstOrDefault(d => d.Name == "Soil Moisture Sensor");
            var TemperatureSensor = allDevices.FirstOrDefault(d => d.Name == "Temperature Sensor");

            var Morning = new List<Device>
            {
                AirConditioner,
                RollerBlindsW,
                AirPurifier,
                KitchenLighting
            };
            var Night = new List<Device>
            {
                AirConditioner,
                RollerBlindsW,
                AirPurifier,
                KitchenLighting
            };
            var Plants = new List<Device>
            {
                SoilMoistureSensor
            };
            var Welcome_Home = new List<Device>
            {
                HallwayLighting,
                AirConditioner,
                AirPurifier
            };
            var Wardrobe_Lighting = new List<Device>
            {
                UnderLighting
            };
            var Kitchen_Lighting = new List<Device>
            {   
                KitchenLighting
            };
            var automations = new List<Automation>
            {
                CreateAutomation("Morning", "Poranek", creator, Morning),
                CreateAutomation("Night", "Noc", creator, Night),
                CreateAutomation("Plants", "Rośliny", creator, Plants),
                CreateAutomation("Welcome Home", "Witaj w domu", creator, Welcome_Home),
                CreateAutomation("Wardrobe Lighting", "Szafa światło", creator, Wardrobe_Lighting),
                CreateAutomation("Kitchen Lighting", "Światło w kuchni", creator, Kitchen_Lighting)
            };
            return automations;
        }
        private Automation CreateAutomation(string name, string namePL, User creator, IList<Device> Devices)
        {
            return new Automation
            {
                Name = name,
                NamePL = namePL,
                Image = LoadImage($"{name.Replace(" ", "_")}.png"),
                TriggerDays = GetRandomDaysOfWeek(),
                TriggerTime = GetRandomTime(),
                CreatedBy = creator,
                Devices = Devices,
            };
            
        }
        public List<DayOfWeek> GetRandomDaysOfWeek()
        {
            var random = new Random();
            int numberOfDaysToSelect = random.Next(1, 8);
            var allDays = Enum.GetValues<DayOfWeek>().ToList();
            var selectedDays = allDays.OrderBy(x => random.Next()).Take(numberOfDaysToSelect).ToList();
            return selectedDays;
        }

        public TimeOnly GetRandomTime()
        {
            var random = new Random();
            int hour = random.Next(0, 24);
            int minute = random.Next(0, 60);
            return new TimeOnly(hour, minute);
        }


    }
}
