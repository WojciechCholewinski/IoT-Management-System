using api.Entities;
using api.Models;

namespace api.Services
{
    public interface IAccountService
    {
        string GenerateJwt(LoginDto dto);
        void RegisterUser(RegisterUserDto dto);
        //User GetUserById(int id);
        void UpdateEmail(UpdateEmailDto dto);
        void UpdateNameAndSurname(UpdateNameDto dto);
        void UpdatePassword(UpdatePasswordDto dto);
    }
}
