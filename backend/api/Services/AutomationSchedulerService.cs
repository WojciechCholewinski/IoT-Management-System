using api.Entities;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class AutomationSchedulerService : BackgroundService
    {
        private readonly IServiceProvider _serviceProvider;
        private Timer _timer;
        private Timer _midnightTimer;

        public AutomationSchedulerService(IServiceProvider serviceProvider)
        {
            _serviceProvider = serviceProvider;
        }

        protected override Task ExecuteAsync(CancellationToken stoppingToken)
        {
            // Uruchamiamy timer, który będzie wywoływać metodę co minutę.
            _timer = new Timer(DoWork, null, TimeSpan.Zero, TimeSpan.FromMinutes(1));

            var now = DateTime.Now;
            var nextMidnight = DateTime.Today.AddDays(1) - now; // Obliczenie odstępu do północy

            // Uruchamiamy timer, który będzie wywoływać metodę codziennie o północy.
            _midnightTimer = new Timer(ResetAutomationsAtMidnight, null, nextMidnight, TimeSpan.FromDays(1));


            return Task.CompletedTask;
        }

        private async void DoWork(object state)
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<IoT_DbContext>();
                var deviceService = scope.ServiceProvider.GetRequiredService<IDeviceService>();

                var now = DateTime.Now;

                var automations = dbContext.Automations
                    .Include(a => a.DevicesToTurnOn)
                    .Include(a => a.DevicesToTurnOff)
                    .Where(a => a.IsOn &&
                                a.TriggerDays.Contains(now.DayOfWeek) &&
                                a.TriggerTime <= TimeOnly.FromTimeSpan(now.TimeOfDay) &&
                                !a.IsTriggeredToday)
                    .ToList();

                foreach (var automation in automations)
                {
                    foreach (var device in automation.DevicesToTurnOn)
                    {
                        if (!device.IsOn)
                        {
                            await deviceService.UpdateIsOn(device.Id, true);
                        }
                    }
                    foreach (var device in automation.DevicesToTurnOff)
                    {
                        if (device.IsOn)
                        {
                            await deviceService.UpdateIsOn(device.Id, false);
                        }
                    }
                    automation.IsTriggeredToday = true;
                }

                await dbContext.SaveChangesAsync();
            }
        }

        private void ResetAutomationsAtMidnight(object state)
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var automationService = scope.ServiceProvider.GetRequiredService<IAutomationService>();
                automationService.ResetIsTriggeredTodayForAllAutomations();
            }
        }

        public override void Dispose()
        {
            _timer?.Dispose();
            _midnightTimer?.Dispose();
            base.Dispose();
        }
    }
}
