using api.Entities;
using api.Models;

namespace api.Services
{
    public interface IAutomationService
    {
        IEnumerable<AutomationDetailDto> GetAll();
    }
}
