using api.Entities;
using api.Models;
using Microsoft.AspNetCore.Mvc;

namespace api.Services
{
    public interface IAutomationService
    {
        IEnumerable<AutomationDetailDto> GetAll();
        AutomationDetailDto GetById(int id);
        bool? Update(int id, AutomationUpdateDto dto);
        void AddDevices(int automationId, AddDevicesToAutomationDto dto);
        void RemoveDevices(int automationId, RemoveDevicesFromAutomationDto dto);
    }
}
