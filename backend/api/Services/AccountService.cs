using api.Entities;
using api.Models;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class AccountService : IAccountService
    {
        private readonly IoT_DbContext _context;

        public AccountService(IoT_DbContext context)
        {
            _context = context;
        }
        public void RegisterUser(RegisterUserDto dto)
        {
            // if FirstName is empty, set the part of the email address before the '@' sign as FirstName
            var firstName = string.IsNullOrWhiteSpace(dto.FirstName)
                ? dto.Email.Split('@')[0]
                : dto.FirstName;

            var newUser = new User() 
            { 
                Email = dto.Email,
                FirstName = firstName,
                RoleId = dto.RoleId,
            };

            _context.Users.Add(newUser);
            _context.SaveChanges();
        }
    }
}
