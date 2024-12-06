using Common.Entities;
using Common.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace Common.Services
{
    public interface IAutomationService
    {
        IEnumerable<AutomationDetailDto> GetAll();
        AutomationDetailDto GetById(int id);
        void Update(int id, AutomationUpdateDto dto);
        void AddDevices(int automationId, AddDevicesToAutomationDto dto);
        void RemoveDevices(int automationId, RemoveDevicesFromAutomationDto dto);

        void ResetIsTriggeredTodayForAllAutomations();
    }
}
