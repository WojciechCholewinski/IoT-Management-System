using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class createLocations : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Location",
                table: "Devices");

            migrationBuilder.AddColumn<int>(
                name: "LocationId",
                table: "Devices",
                type: "int",
                nullable: true);

            migrationBuilder.CreateTable(
                name: "LocationTypes",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_LocationTypes", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_Devices_LocationId",
                table: "Devices",
                column: "LocationId");

            migrationBuilder.AddForeignKey(
                name: "FK_Devices_LocationTypes_LocationId",
                table: "Devices",
                column: "LocationId",
                principalTable: "LocationTypes",
                principalColumn: "Id");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Devices_LocationTypes_LocationId",
                table: "Devices");

            migrationBuilder.DropTable(
                name: "LocationTypes");

            migrationBuilder.DropIndex(
                name: "IX_Devices_LocationId",
                table: "Devices");

            migrationBuilder.DropColumn(
                name: "LocationId",
                table: "Devices");

            migrationBuilder.AddColumn<string>(
                name: "Location",
                table: "Devices",
                type: "nvarchar(max)",
                nullable: true);
        }
    }
}
