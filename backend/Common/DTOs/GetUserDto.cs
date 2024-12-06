using Common.Entities;

namespace Common.DTOs
{
    public class GetUserDto
    {
        public string Email { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public byte[] Photo { get; set; }
    }
}
