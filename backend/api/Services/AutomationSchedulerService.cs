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

        private void DoWork(object state)
        {
            using (var scope = _serviceProvider.CreateScope())
            {
                var dbContext = scope.ServiceProvider.GetRequiredService<IoT_DbContext>();
                var now = DateTime.Now;

                var automations = dbContext.Automations
                    .Include(a => a.Devices)
                    .Where(a => a.IsOn &&
                                a.TriggerDays.Contains(now.DayOfWeek) &&
                                a.TriggerTime <= TimeOnly.FromTimeSpan(now.TimeOfDay) &&
                                !a.IsTriggeredToday)
                    .ToList();

                foreach (var automation in automations)
                {
                    foreach (var device in automation.Devices)
                    {
                        device.IsOn = !device.IsOn;
                        device.LastUpdate = now;
                    }
                    automation.IsTriggeredToday = true;
                }

                dbContext.SaveChanges();
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
