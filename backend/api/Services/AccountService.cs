using api.Entities;
using api.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

namespace api.Services
{
    public class AccountService : IAccountService
    {
        private readonly IoT_DbContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;

        public AccountService(IoT_DbContext context, IPasswordHasher<User> passwordHasher)
        {
            _context = context;
            _passwordHasher = passwordHasher;
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
            var hashedPassword = _passwordHasher.HashPassword(newUser, dto.Password);
            newUser.PasswordHash = hashedPassword;

            _context.Users.Add(newUser);
            _context.SaveChanges();
        }
    }
}
