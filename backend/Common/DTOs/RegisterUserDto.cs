using System.ComponentModel.DataAnnotations;

namespace Common.DTOs
{
    public class RegisterUserDto
    {
        public string Email { get; set; }
        public string? FirstName { get; set; }
        public string Password { get; set; }
        public string ConfirmPassword { get; set; }
        public int RoleId { get; set; } = 2;
    }
}
