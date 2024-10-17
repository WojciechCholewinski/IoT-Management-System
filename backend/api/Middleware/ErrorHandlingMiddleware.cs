using api.Exceptions;

namespace api.Middleware
{
    public class ErrorHandlingMiddleware : IMiddleware
    {
        private readonly ILogger<ErrorHandlingMiddleware> _logger;

        public ErrorHandlingMiddleware(ILogger<ErrorHandlingMiddleware> logger)
        {
            _logger = logger;
        }
        public async Task InvokeAsync(HttpContext context, RequestDelegate next)
        {
            try
            {
                await next.Invoke(context);
            }
            catch (UnauthorizedException unauthorizedException)
            {
                context.Response.StatusCode = 401;
                _logger.LogError(unauthorizedException.Message);
                await context.Response.WriteAsync(unauthorizedException.Message);
            }
            catch (ForbiddenException forbiddenException)
            {
                context.Response.StatusCode = 403;
                _logger.LogError(forbiddenException.Message);
                await context.Response.WriteAsync(forbiddenException.Message);
            }
            catch (NotFoundException notFoundException)
            {
                context.Response.StatusCode = 404;
                _logger.LogError(notFoundException.Message);
                await context.Response.WriteAsync(notFoundException.Message);
            }
            catch (ConflictException conflictException)
            {
                context.Response.StatusCode = 409;
                _logger.LogError(conflictException.Message);
                await context.Response.WriteAsync(conflictException.Message);
            }
            catch (Exception ex)
            {
                context.Response.StatusCode = 500;
                _logger.LogError(ex, ex.Message);
                await context.Response.WriteAsync("sth went wrong");
            }
        }
    }
}
