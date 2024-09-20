using api.Entities;
using Microsoft.EntityFrameworkCore;
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
                var pendingMigrations = _dbContext.Database.GetPendingMigrations();
                if (pendingMigrations != null && pendingMigrations.Any())
                {
                    _dbContext.Database.Migrate();
                }

                if (!_dbContext.Roles.Any())
                {
                    var roles = GetRoles();
                    _dbContext.Roles.AddRange(roles);

                    _dbContext.SaveChanges();
                }

                SeedUser();

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
        private void SeedUser()
        {
            if (!_dbContext.Users.Any(u => u.Email == "t@test.com"))
            {
                var userRole = _dbContext.Roles.FirstOrDefault(r => r.Name == "User") ?? throw new InvalidOperationException("Role 'User' does not exist. Please seed roles before seeding users.");
                var user = new User
                {
                    Email = "t@test.com",
                    FirstName = "Test",
                    LastName = "User",
                    PasswordHash = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzI3NTczNzA1LCJpc3MiOiJodHRwOi8vaW90YXBpLnNodGV5ZW4ucGwiLCJhdWQiOiJodHRwOi8vaW90YXBpLnNodGV5ZW4ucGwifQ.Sphl6KRZ7KJRpOZOhpXAQoB75Z45BHH0Y-ATChE0SF8",
                    Photo = LoadImage("ProfilePhoto.png") ?? new byte[0],
                    Role = userRole
                };

                _dbContext.Users.Add(user);
                _dbContext.SaveChanges();
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
                CreateAutomation("Morning", "Poranek", creator, Morning, null),
                CreateAutomation("Night", "Noc", creator, null, Night),
                CreateAutomation("Plants", "Rośliny", creator, Plants, Plants),
                CreateAutomation("Welcome Home", "Witaj w domu", creator, Welcome_Home, null),
                CreateAutomation("Wardrobe Lighting", "Szafa światło", creator, Wardrobe_Lighting, null),
                CreateAutomation("Kitchen Lighting", "Światło w kuchni", creator, Kitchen_Lighting, null)
            };
            return automations;
        }
        private Automation CreateAutomation(string name, string namePL, User creator, IList<Device>? DevicesToTurnOn, IList<Device>? DevicesToTurnOff)
        {
            return new Automation
            {
                Name = name,
                NamePL = namePL,
                Image = LoadImage($"{name.Replace(" ", "_")}.png"),
                TriggerDays = GetRandomDaysOfWeek(),
                TriggerTime = GetRandomTime(),
                CreatedBy = creator,
                DevicesToTurnOn = DevicesToTurnOn,
                DevicesToTurnOff = DevicesToTurnOff,
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
