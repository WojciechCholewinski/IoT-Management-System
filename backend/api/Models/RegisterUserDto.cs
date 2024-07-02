using System.ComponentModel.DataAnnotations;

namespace api.Models
{
    public class RegisterUserDto
    {
        [Required]
        public string Email { get; set; }
        public string? FirstName { get; set; }
        [Required]
        [MinLength(4)]
        public string Password { get; set; }
        public int RoleId { get; set; } = 2;
    }
}
