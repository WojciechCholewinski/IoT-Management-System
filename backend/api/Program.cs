using api;
using api.Entities;
using api.Models;
using api.Models.Validators;
using api.Services;
using FluentValidation;
using FluentValidation.AspNetCore;
using Microsoft.AspNetCore.Identity;
using System.Reflection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Enables automatic validation of models using FluentValidation:
builder.Services.AddFluentValidationAutoValidation();
// Registers FluentValidation client-side adapters for integration with client-side validation:
builder.Services.AddFluentValidationClientsideAdapters();

builder.Services.AddDbContext<IoT_DbContext>();
builder.Services.AddScoped<ApiSeeder>();
builder.Services.AddScoped<IPasswordHasher<User>, PasswordHasher<User>>();
builder.Services.AddScoped<IValidator<RegisterUserDto>, RegisterUserDtoValidator>();
builder.Services.AddAutoMapper(Assembly.GetExecutingAssembly());
builder.Services.AddCors(options =>
{
    options.AddPolicy("FrontendClient", builder =>
        builder.AllowAnyMethod()
        .AllowAnyHeader()
        .AllowAnyOrigin()
        );
});
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IDeviceService, DeviceService>();
builder.Services.AddScoped<IAccountService, AccountService>();


var app = builder.Build();

// Configure the HTTP request pipeline.

app.UseCors("FrontendClient");

var scope = app.Services.CreateScope();
var seeder = scope.ServiceProvider.GetRequiredService<ApiSeeder>();
seeder.Seed();

app.UseHttpsRedirection();

app.UseSwagger();
app.UseSwaggerUI(c =>
{
    c.SwaggerEndpoint("/swagger/v1/swagger.json", "IoT API");
});

app.UseAuthorization();

app.MapControllers();

app.Run();
