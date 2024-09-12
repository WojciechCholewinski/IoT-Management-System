using api.Exceptions;
using api.Models;
using api.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;

namespace api.Controllers
{
    [Route("api/account")]
    [ApiController]
    public class AccountController : ControllerBase
    {
        private readonly IAccountService _accountService;

        public AccountController(IAccountService accountService)
        {
            _accountService = accountService;
        }
        //[HttpGet("{id}")]
        //public ActionResult<UserDto> GetUser(int id)
        //{
        //    var user = _accountService.GetUserById(id);
        //    if (user == null)
        //    {
        //        return NotFound();
        //    }

        //    return Ok(user);
        //}
        //[HttpPost("register")]
        //public ActionResult RegisterUser([FromBody] RegisterUserDto dto)
        //{
        //    _accountService.RegisterUser(dto);
        //    //return Created();
        //    return CreatedAtAction(nameof(GetUser), new { id = dto.Email }, dto);
        //}

        [HttpPost("register")]
        [ProducesResponseType(StatusCodes.Status201Created)] // By Swagger wiedział o statusie 201
        [ProducesResponseType(StatusCodes.Status400BadRequest)] // Dla ewentualnych błędów walidacji z fluentvalidation
        public ActionResult RegisterUser([FromBody] RegisterUserDto dto)
        {
            _accountService.RegisterUser(dto);
            return StatusCode(StatusCodes.Status201Created);
        }

        [HttpPost("login")]
        [ProducesResponseType(StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult Login([FromBody] LoginDto dto)
        {
            try
            {
                string token = _accountService.GenerateJwt(dto);
                return Ok(token);
            }
            catch (BadRequestException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
        }

        [Authorize]
        [HttpPatch("name")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public ActionResult ChangeNameAndSurname([FromBody] UpdateNameDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdateNameAndSurname(dto);
            return NoContent();
        }

        [Authorize]
        [HttpPatch("email")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult ChangeEmail([FromBody] UpdateEmailDto dto)
        {
            var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
            dto.Id = userId;
            _accountService.UpdateEmail(dto);
            return NoContent();
        }

        [Authorize]
        [HttpPatch("password")]
        [ProducesResponseType(StatusCodes.Status204NoContent)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        public ActionResult ChangePassword([FromBody] UpdatePasswordDto dto)
        {
            try
            {
                var userId = int.Parse(User.FindFirst(ClaimTypes.NameIdentifier).Value);
                dto.Id = userId;
                _accountService.UpdatePassword(dto);
                return NoContent();
            }
            catch (BadRequestException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (NotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
        }
    }
}
// TODO: add Refresh Token