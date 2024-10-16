using api;
using api.Entities;
using api.Middleware;
using api.Models;
using api.Models.Validators;
using api.Services;
using FluentValidation;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using NLog.Web;
using System.Reflection;
using System.Text;
using System.Text.Json.Serialization;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

var authenticationSettings = new AuthenticationSettings();
builder.Configuration.GetSection("Authentication").Bind(authenticationSettings);
builder.Services.AddSingleton(authenticationSettings);
builder.Services.AddAuthentication(option =>
{
    option.DefaultAuthenticateScheme = "Bearer";
    option.DefaultScheme = "Bearer";
    option.DefaultChallengeScheme = "Bearer";
}).AddJwtBearer(cfg =>
{
    cfg.RequireHttpsMetadata = false;
    cfg.SaveToken = true;
    cfg.TokenValidationParameters = new TokenValidationParameters
    {
        ValidIssuer = authenticationSettings.JwtIssuer,
        ValidAudience = authenticationSettings.JwtIssuer,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(authenticationSettings.JwtKey)),
    };
});

// Enables automatic validation of models using FluentValidation:
builder.Services.AddFluentValidationAutoValidation();
// Registers FluentValidation client-side adapters for integration with client-side validation:
builder.Services.AddFluentValidationClientsideAdapters();

builder.Services.AddDbContext<IoT_DbContext>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("IoTDbConnection")));
builder.Services.AddScoped<ApiSeeder>();
builder.Services.AddScoped<IPasswordHasher<User>, PasswordHasher<User>>();
builder.Services.AddScoped<IValidator<RegisterUserDto>, RegisterUserDtoValidator>();
builder.Services.AddScoped<IValidator<UpdateEmailDto>, UpdateEmailDtoValidator>();
builder.Services.AddScoped<IValidator<UpdatePasswordDto>, UpdatePasswordDtoValidator>();
builder.Services.AddScoped<ErrorHandlingMiddleware>();
builder.Services.AddAutoMapper(Assembly.GetExecutingAssembly());
builder.Services.AddHostedService<AutomationSchedulerService>();

builder.Services.AddCors(options =>
{
    options.AddPolicy("FrontendClient", builder =>
        builder.AllowAnyMethod()
        .AllowAnyHeader()
        .AllowAnyOrigin()
        );
});
builder.Services.AddSwaggerGen();
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter());
    });


builder.Services.AddScoped<IDeviceService, DeviceService>();
builder.Services.AddScoped<IAutomationService, AutomationService>();
builder.Services.AddScoped<IAccountService, AccountService>();


builder.Logging.ClearProviders();
builder.Host.UseNLog();

var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseCors("FrontendClient");

var scope = app.Services.CreateScope();
// Zastosowanie migracji przy starcie aplikacji
var dbContext = scope.ServiceProvider.GetRequiredService<IoT_DbContext>();
dbContext.Database.Migrate();

var configuration = scope.ServiceProvider.GetRequiredService<IConfiguration>();
var seeder = scope.ServiceProvider.GetRequiredService<ApiSeeder>();
seeder.Seed();

app.UseMiddleware<ErrorHandlingMiddleware>();
app.UseAuthentication();
app.UseHttpsRedirection();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "IoT API");
});

app.UseAuthorization();

app.MapControllers();

app.Run();
