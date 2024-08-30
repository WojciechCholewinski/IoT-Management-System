using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using System.Data;
using System.Net;

namespace api.Entities
{
    public class IoT_DbContext : DbContext
    {
        private string _connectionString = 
            "Server=(localdb)\\mssqllocaldb;Database=bin2Db; Trusted_Connection=True;";

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

            modelBuilder.Entity<Automation>().HasMany(a => a.Devices);

        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_connectionString);
        }
    }
}
