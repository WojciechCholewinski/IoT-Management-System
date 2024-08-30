using api.Entities;
using api.Models;
using AutoMapper;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class AutomationService : IAutomationService
    {
        private readonly IoT_DbContext _dbContext;
        private readonly IMapper _mapper;

        public AutomationService(IoT_DbContext dbContext, IMapper mapper) 
        {
            _dbContext = dbContext;
            _mapper = mapper;
        }
        public IEnumerable<AutomationDetailDto> GetAll()
        {
            var automations = 
                _dbContext
                .Automations
                .Include(a => a.CreatedBy)
                .Include(a => a.Devices)
                .ToList();

            var automationsDtos = _mapper.Map<List<AutomationDetailDto>>(automations);
            return automationsDtos;
        }
    }
}
