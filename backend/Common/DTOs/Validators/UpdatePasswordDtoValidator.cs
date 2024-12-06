using Common.Entities;
using FluentValidation;

namespace Common.DTOs.Validators
{
    public class UpdatePasswordDtoValidator : AbstractValidator<UpdatePasswordDto>
    {
        public UpdatePasswordDtoValidator()
        {
            RuleFor(x => x.Password)
                .NotEmpty()
                .MinimumLength(4)
                .NotEqual(x => x.PreviousPassword);

            RuleFor(x => x.ConfirmPassword)
                .NotEmpty()
                .Equal(x => x.Password);
        }
    }
}
