using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class converttypeofRunTimefromTimeSpantoRunTimeTickstypelongBIGINT : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RunTime",
                table: "Devices");

            migrationBuilder.AddColumn<long>(
                name: "RunTimeTicks",
                table: "Devices",
                type: "bigint",
                nullable: false,
                defaultValue: 0L);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "RunTimeTicks",
                table: "Devices");

            migrationBuilder.AddColumn<TimeSpan>(
                name: "RunTime",
                table: "Devices",
                type: "time",
                nullable: false,
                defaultValue: new TimeSpan(0, 0, 0, 0, 0));
        }
    }
}
