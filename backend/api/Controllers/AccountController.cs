using Common.DTOs;
using Common.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace api.Controllers
{
    /// <summary>
    /// AccountController manages user-related operations, such as registration, login, 
    /// profile management, and updates to user information (e.g., name, email, password, and profile photo).
    /// </summary>
    /// <remarks>
    /// This controller handles all account-related endpoints, including authentication and authorization.
    /// Some methods require user authentication via JWT token.
    /// </remarks>

    [Route("api/account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }

        /// <summary>
        /// Retrieves the profile data of the currently logged-in user.
        /// </summary>
        /// <response code="200">(OK)           Returned when the user's profile data has been successfully retrieved.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when the user with the given ID was not found.</response>
        [Authorize]
        [HttpGet("me")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult<GetUserDto> GetMyProfileData()
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            var user = _accountService.GetById(userId);
            return Ok(user);
        }

        /// <summary>
        /// Registers a new user in the system.
        /// </summary>
        /// <response code="201">(Created)      Returned when the user has been successfully registered.</response>
        /// <response code="400">(BadRequest)   Returned when: the email is not a valid email address, the password is shorter than 4 characters or does not match the ConfirmPassword, or the email is already in use by another account.</response>
        [HttpPost("register")]
        [ProducesResponseType(StatusCodes.Status201Created)] // By Swagger wiedział o statusie 201
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Dla ewentualnych błędów walidacji z fluentvalidation
        public ActionResult RegisterUser([FromBody] RegisterUserDto dto)
        {
            _accountService.RegisterUser(dto);
            return StatusCode(StatusCodes.Status201Created);
        }

        /// <summary>
        /// Authenticates the user and returns a JWT token upon successful login.
        /// </summary>
        /// <response code="200">(OK)           Returned when the user has been successfully authenticated and a JWT token is generated.</response>
        /// <response code="400">(BadRequest)   Returned when the input data is invalid, such as missing email, invalid email format, or missing password.</response>
        /// <response code="401">(Unauthorized) Returned when the email or password is incorrect.</response>
        // TODO: nie mam dodanej walidacji fluentValidation do tego case-u (do code 400).
        [HttpPost("login")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        public ActionResult Login([FromBody] LoginDto dto)
        {
            string token = _accountService.GenerateJwt(dto);
            return Ok(token);
        }

        /// <summary>
        /// Updates the first name and last name of the currently logged-in user.
        /// </summary>
        /// <response code="204">(NoContent)    Returned when the user's name and/or surname have been successfully updated.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when a user with the given ID was not found.</response>
        [Authorize]
        [HttpPatch("name")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult ChangeNameAndSurname([FromBody] UpdateNameDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdateNameAndSurname(dto);
            return NoContent();
        }

        /// <summary>
        /// Changes the email address of the logged-in user.
        /// </summary>
        /// <response code="204">(NoContent)    Returned when the email has been successfully updated.</response>
        /// <response code="400">(BadRequest)   Returned when the input data is invalid, such as missing email, incorrect format, or if the email is already in use.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound)     Returned when a user with the given ID was not found.</response>
        [Authorize]
        [HttpPatch("email")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult ChangeEmail([FromBody] UpdateEmailDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdateEmail(dto);
            return NoContent();
        }

        /// <summary>
        /// Changes the password of the currently logged-in user.
        /// </summary>
        /// <response code="204">(NoContent) Returned when the user's password has been successfully updated.</response>
        /// <response code="400">(BadRequest) Returned when the Password is empty, less than 4 characters long, matches the PreviousPassword, or when ConfirmPassword is not provided or does not match the new Password.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="403">(Forbidden) Returned when the provided previous password is incorrect.</response>
        /// <response code="404">(NotFound) Returned when a user with the given ID was not found.</response>
        [Authorize]
        [HttpPatch("password")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status403Forbidden)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult ChangePassword([FromBody] UpdatePasswordDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdatePassword(dto);
            return NoContent();
        }

        /// <summary>
        /// Updates the profile photo of the currently logged-in user.
        /// </summary>
        /// <response code="204">(NoContent) Returned when the user's profile photo has been successfully updated.</response>
        /// <response code="401">(Unauthorized) Returned when the user is not authenticated.</response>
        /// <response code="404">(NotFound) Returned when a user with the given ID was not found.</response>
        [Authorize]
        [HttpPatch("photo")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status401Unauthorized)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult ChangePhoto([FromBody] UpdatePhotoDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdatePhoto(dto);
            return NoContent();
        }
    }
}
// TODO: add Refresh Token