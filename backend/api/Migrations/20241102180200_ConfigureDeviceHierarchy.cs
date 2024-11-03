using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class ConfigureDeviceHierarchy : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DeviceType",
                table: "Devices",
                type: "nvarchar(21)",
                maxLength: 21,
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddColumn<DateTime>(
                name: "LastTrigger",
                table: "Devices",
                type: "datetime2",
                nullable: true);

            migrationBuilder.AddColumn<long>(
                name: "RealRuntimeTicks",
                table: "Devices",
                type: "bigint",
                nullable: true);

            migrationBuilder.AddColumn<TimeSpan>(
                name: "TimeOfWork",
                table: "Devices",
                type: "time",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DeviceType",
                table: "Devices");

            migrationBuilder.DropColumn(
                name: "LastTrigger",
                table: "Devices");

            migrationBuilder.DropColumn(
                name: "RealRuntimeTicks",
                table: "Devices");

            migrationBuilder.DropColumn(
                name: "TimeOfWork",
                table: "Devices");
        }
    }
}
