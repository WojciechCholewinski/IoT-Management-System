using Common.Entities;
using Common.DTOs;
using AutoMapper;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.Extensions.Configuration;
using api.Exceptions;
using Common.Configuration;

namespace Common.Services
{
    public class AccountService : IAccountService
    {
        private readonly IoT_DbContext _context;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly AuthenticationSettings _authenticationSettings;
        private readonly string _imagesPath;
        private readonly IMapper _mapper;

        public AccountService(IoT_DbContext context, IPasswordHasher<User> passwordHasher, AuthenticationSettings authenticationSettings, IConfiguration configuration, IMapper mapper)
        {
            _context = context;
            _passwordHasher = passwordHasher;
            _authenticationSettings = authenticationSettings;
            _mapper = mapper;
            _imagesPath = configuration["ImagesPath"];
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
                Photo = LoadImage($"ProfilePhoto.png"),
            };
            var hashedPassword = _passwordHasher.HashPassword(newUser, dto.Password);
            newUser.PasswordHash = hashedPassword;

            _context.Users.Add(newUser);
            _context.SaveChanges();
        }
        private byte[] LoadImage(string fileName)
        {
            var filePath = Path.Combine(_imagesPath, fileName);

            if (File.Exists(filePath))
            {
                return File.ReadAllBytes(filePath);
            }
            else
            {
                throw new NotFoundException("Image not found");
            }
        }
        public string GenerateJwt(LoginDto dto)
        {
            var user = _context.Users
                .Include(u => u.Role)
                .FirstOrDefault(u => u.Email == dto.Email)
                ?? throw new UnauthorizedException("Invalid username or password");

            var result = _passwordHasher.VerifyHashedPassword(user, user.PasswordHash, dto.Password);
            if (result == PasswordVerificationResult.Failed)
                throw new UnauthorizedException("Invalid username or password");

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

        // metoda służąca do pobierania danych profilowych aktualnie zalogowanego użytkownika
        public GetUserDto GetById(int id)
        {
            var user = GetUserById(id);

            var userDto = _mapper.Map<GetUserDto>(user);
            return userDto;

        }

        // metoda refaktoryzująca kod wyszukiwania usera w bazie wykorzystywana w klasie AccountService.cs
        private User GetUserById(int id)
        {
            var user = _context
                .Users
                .Include(u => u.Role)
                .FirstOrDefault(u => u.Id == id)
                ?? throw new NotFoundException("User not found");
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
                throw new ForbiddenException("Old password is incorrect");

            var hashedPassword = _passwordHasher.HashPassword(user, dto.Password);
            user.PasswordHash = hashedPassword;

            _context.SaveChanges();
        }

        public void UpdatePhoto(UpdatePhotoDto dto)
        {
            var user = GetUserById(dto.Id);

            user.Photo = dto.Photo;
            _context.SaveChanges();
        }
    }
}
