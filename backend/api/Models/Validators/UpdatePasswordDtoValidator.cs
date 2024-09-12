using api.Entities;
using FluentValidation;

namespace api.Models.Validators
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
