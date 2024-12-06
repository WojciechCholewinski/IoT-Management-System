using Common.Entities;
using Common.DTOs;

namespace Common.Services
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
