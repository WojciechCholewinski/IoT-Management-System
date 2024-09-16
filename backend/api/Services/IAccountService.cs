using api.Entities;
using api.Models;

namespace api.Services
{
    public interface IAccountService
    {
        string GenerateJwt(LoginDto dto);
        void RegisterUser(RegisterUserDto dto);
        GetUserDto GetById(int id);
        void UpdateEmail(UpdateEmailDto dto);
        void UpdateNameAndSurname(UpdateNameDto dto);
        void UpdatePassword(UpdatePasswordDto dto);
        void UpdatePhoto(UpdatePhotoDto dto);
    }
}
