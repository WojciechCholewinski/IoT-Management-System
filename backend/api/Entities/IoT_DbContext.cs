using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using System.Data;
using System.Net;

namespace api.Entities
{
    public class IoT_DbContext : DbContext
    {
        private string _connectionString = 
            "Server=(localdb)\\mssqllocaldb;Database=IoTManagementSystemDb; Trusted_Connection=True;";

        public DbSet<Device> Devices { get; set; }
        public DbSet<LocationType> LocationTypes { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Device>()
                .Property(d => d.Name)
                .IsRequired();

            modelBuilder.Entity<Device>()
                .Property(d => d.IsOn)
                .IsRequired();

            modelBuilder.Entity<LocationType>()
                .Property(l => l.Name)
                .IsRequired();
        }
        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(_connectionString);
        }
    }
}
