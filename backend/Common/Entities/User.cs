namespace Common.Entities
{
    public class User
    {
        public int Id { get; set; }
        public required string Email { get; set; }
        public required string FirstName { get; set; }
        public string? LastName { get; set; }
        public string? PasswordHash { get; set; }
        public required byte[] Photo { get; set; }

        public int RoleId { get; set; }
        public virtual Role Role { get; set; }
    }
}
