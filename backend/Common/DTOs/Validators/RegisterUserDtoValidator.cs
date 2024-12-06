using Common.Entities;
using FluentValidation;

namespace Common.DTOs.Validators
{
    public class RegisterUserDtoValidator : AbstractValidator<RegisterUserDto>
    {
        public RegisterUserDtoValidator(IoT_DbContext dbContext)
        {
            RuleFor(x => x.Email)
                .NotEmpty()
                .EmailAddress();

            RuleFor(x => x.Password)
                .NotEmpty()
                .MinimumLength(4)
                .Equal(x => x.ConfirmPassword);

            RuleFor(x => x.Email)
                .Custom((value, context) =>
                {
                var emailInUse = dbContext.Users.Any(u => u.Email == value);
                    if (emailInUse) 
                    { 
                        context.AddFailure("Email", "Email is taken"); 
                    };
                });
        }
    }
}
