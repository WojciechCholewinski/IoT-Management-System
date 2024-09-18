using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace api.Migrations
{
    /// <inheritdoc />
    public partial class AddDevicesToTurnOnAndTurnOffColumns : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AutomationDevice_Automations_AutomationsId",
                table: "AutomationDevice");

            migrationBuilder.DropForeignKey(
                name: "FK_AutomationDevice_Devices_DevicesId",
                table: "AutomationDevice");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AutomationDevice",
                table: "AutomationDevice");

            migrationBuilder.RenameTable(
                name: "AutomationDevice",
                newName: "AutomationDevicesToTurnOn");

            migrationBuilder.RenameColumn(
                name: "DevicesId",
                table: "AutomationDevicesToTurnOn",
                newName: "DevicesToTurnOnId");

            migrationBuilder.RenameColumn(
                name: "AutomationsId",
                table: "AutomationDevicesToTurnOn",
                newName: "AutomationsToTurnOnId");

            migrationBuilder.RenameIndex(
                name: "IX_AutomationDevice_DevicesId",
                table: "AutomationDevicesToTurnOn",
                newName: "IX_AutomationDevicesToTurnOn_DevicesToTurnOnId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AutomationDevicesToTurnOn",
                table: "AutomationDevicesToTurnOn",
                columns: new[] { "AutomationsToTurnOnId", "DevicesToTurnOnId" });

            migrationBuilder.CreateTable(
                name: "AutomationDevicesToTurnOff",
                columns: table => new
                {
                    AutomationsToTurnOffId = table.Column<int>(type: "int", nullable: false),
                    DevicesToTurnOffId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AutomationDevicesToTurnOff", x => new { x.AutomationsToTurnOffId, x.DevicesToTurnOffId });
                    table.ForeignKey(
                        name: "FK_AutomationDevicesToTurnOff_Automations_AutomationsToTurnOffId",
                        column: x => x.AutomationsToTurnOffId,
                        principalTable: "Automations",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_AutomationDevicesToTurnOff_Devices_DevicesToTurnOffId",
                        column: x => x.DevicesToTurnOffId,
                        principalTable: "Devices",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                });

            migrationBuilder.CreateIndex(
                name: "IX_AutomationDevicesToTurnOff_DevicesToTurnOffId",
                table: "AutomationDevicesToTurnOff",
                column: "DevicesToTurnOffId");

            migrationBuilder.AddForeignKey(
                name: "FK_AutomationDevicesToTurnOn_Automations_AutomationsToTurnOnId",
                table: "AutomationDevicesToTurnOn",
                column: "AutomationsToTurnOnId",
                principalTable: "Automations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AutomationDevicesToTurnOn_Devices_DevicesToTurnOnId",
                table: "AutomationDevicesToTurnOn",
                column: "DevicesToTurnOnId",
                principalTable: "Devices",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AutomationDevicesToTurnOn_Automations_AutomationsToTurnOnId",
                table: "AutomationDevicesToTurnOn");

            migrationBuilder.DropForeignKey(
                name: "FK_AutomationDevicesToTurnOn_Devices_DevicesToTurnOnId",
                table: "AutomationDevicesToTurnOn");

            migrationBuilder.DropTable(
                name: "AutomationDevicesToTurnOff");

            migrationBuilder.DropPrimaryKey(
                name: "PK_AutomationDevicesToTurnOn",
                table: "AutomationDevicesToTurnOn");

            migrationBuilder.RenameTable(
                name: "AutomationDevicesToTurnOn",
                newName: "AutomationDevice");

            migrationBuilder.RenameColumn(
                name: "DevicesToTurnOnId",
                table: "AutomationDevice",
                newName: "DevicesId");

            migrationBuilder.RenameColumn(
                name: "AutomationsToTurnOnId",
                table: "AutomationDevice",
                newName: "AutomationsId");

            migrationBuilder.RenameIndex(
                name: "IX_AutomationDevicesToTurnOn_DevicesToTurnOnId",
                table: "AutomationDevice",
                newName: "IX_AutomationDevice_DevicesId");

            migrationBuilder.AddPrimaryKey(
                name: "PK_AutomationDevice",
                table: "AutomationDevice",
                columns: new[] { "AutomationsId", "DevicesId" });

            migrationBuilder.AddForeignKey(
                name: "FK_AutomationDevice_Automations_AutomationsId",
                table: "AutomationDevice",
                column: "AutomationsId",
                principalTable: "Automations",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_AutomationDevice_Devices_DevicesId",
                table: "AutomationDevice",
                column: "DevicesId",
                principalTable: "Devices",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
