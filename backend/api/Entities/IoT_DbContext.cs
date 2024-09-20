using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using System.Data;
using System.Net;

namespace api.Entities
{
    public class IoT_DbContext : DbContext
    {
        public IoT_DbContext(DbContextOptions<IoT_DbContext> options) : base(options)
        {
            
        }
        public DbSet<Device> Devices { get; set; }
        public DbSet<LocationType> LocationTypes { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<Automation> Automations { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .Property(u => u.Email)
                .IsRequired();

            modelBuilder.Entity<Role>()
                .Property(r => r.Name)
                .IsRequired();

            modelBuilder.Entity<Device>()
                .Property(d => d.Name)
                .IsRequired();

            modelBuilder.Entity<Device>()
                .Property(d => d.IsOn)
                .IsRequired();

            modelBuilder.Entity<LocationType>()
                .Property(l => l.Name)
                .IsRequired();

            modelBuilder.Entity<Automation>()
                .Property(a => a.Name)
                .IsRequired();

            modelBuilder.Entity<Automation>()
                .Property(a => a.NamePL)
                .IsRequired();

            modelBuilder.Entity<Automation>()
                .Property(a => a.Image)
                .IsRequired();

            modelBuilder.Entity<Automation>()
                .Property(a => a.TriggerDays)
                .IsRequired();

            modelBuilder.Entity<Automation>()
                .Property(a => a.TriggerTime)
                .IsRequired();

            modelBuilder.Entity<Automation>().HasOne(a => a.CreatedBy);

            modelBuilder.Entity<Automation>()
                .HasMany(a => a.DevicesToTurnOn)
                .WithMany(d => d.AutomationsToTurnOn)
                .UsingEntity(j => j.ToTable("AutomationDevicesToTurnOn"));

            modelBuilder.Entity<Automation>()
                .HasMany(a => a.DevicesToTurnOff)
                .WithMany(d => d.AutomationsToTurnOff)
                .UsingEntity(j => j.ToTable("AutomationDevicesToTurnOff"));

            modelBuilder.Entity<Device>()
                .HasMany(d => d.AutomationsToTurnOn)
                .WithMany(a => a.DevicesToTurnOn)
                .UsingEntity(j => j.ToTable("AutomationDevicesToTurnOn"));

            modelBuilder.Entity<Device>()
                .HasMany(d => d.AutomationsToTurnOff)
                .WithMany(a => a.DevicesToTurnOff)
                .UsingEntity(j => j.ToTable("AutomationDevicesToTurnOff"));

        }
    }
}
