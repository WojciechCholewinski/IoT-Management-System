namespace Common.DTOs
{
    public class UpdatePasswordDto
    {
        public int Id { get; set; }
        public required string PreviousPassword { get; set; }
        public required string Password { get; set; }
        public required string ConfirmPassword { get; set; }
    }
}