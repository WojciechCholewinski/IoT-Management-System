using api.Entities;
using api.Exceptions;
using api.Models;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography.Xml;
using System.Text;

namespace api.Services
{
    public class AccountService : IAccountService
    {
        private readonly IoT_DbContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly AuthenticationSettings _authenticationSettings;

        public AccountService(IoT_DbContext context, IPasswordHasher<User> passwordHasher, AuthenticationSettings authenticationSettings)
        {
            _context = context;
            _passwordHasher = passwordHasher;
            _authenticationSettings = authenticationSettings;
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
        public string GenerateJwt(LoginDto dto)
        {
            var user = _context.Users
                .Include(u => u.Role)
                .FirstOrDefault(u => u.Email == dto.Email);
            if (user == null)
            {
                throw new BadRequestException("Invalid username or password");
            }

            var result = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (result == PasswordVerificationResult.Failed)
            {
                throw new BadRequestException("Invalid username or password");
            }

            var claims = new List<Claim>()
            {
                new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new Claim(ClaimTypes.Role, $"{user.Role.Name}")
            };

            var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_authenticationSettings.JwtKey));
            var cred = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
            var expires = DateTime.Now.AddDays(_authenticationSettings.JwtExpireDays);

            var token = new JwtSecurityToken(
                _authenticationSettings.JwtIssuer,
                _authenticationSettings.JwtIssuer,
                claims,
                expires: expires,
                signingCredentials: cred);

            var tokenHandler = new JwtSecurityTokenHandler();
            return tokenHandler.WriteToken(token);
        }


        private User GetUserById(int id)
        {
            var user = _context
                .Users
                .Include(u => u.Role)
                .FirstOrDefault(u => u.Id == id);

            if (user == null)
            {
                throw new NotFoundException("User not found");
            }
            return user;
        }


        public void UpdateNameAndSurname(UpdateNameDto dto)
        {
            var user = GetUserById(dto.Id);

            user.FirstName = dto.FirstName ?? user.FirstName;
            user.LastName = dto.LastName ?? user.LastName;

            _context.SaveChanges();
        }

        public void UpdateEmail(UpdateEmailDto dto)
        {
            var user = GetUserById(dto.Id);

            user.Email = dto.Email;

            _context.SaveChanges();
        }

        public void UpdatePassword(UpdatePasswordDto dto)
        {
            var user = GetUserById(dto.Id);

            var result = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.PreviousPassword);
            if (result == PasswordVerificationResult.Failed)
            {
                throw new BadRequestException("Old password is incorrect");
            }

            var hashedPassword = _passwordHasher.HashPassword(user, dto.Password);
            user.PasswordHash = hashedPassword;

            _context.SaveChanges();
        }
    }
}
