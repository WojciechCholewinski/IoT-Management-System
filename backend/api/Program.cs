using api;
using api.Entities;
using api.Services;
using System.Reflection;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();

builder.Services.AddDbContext<IoT_DbContext>();
builder.Services.AddScoped<ApiSeeder>();
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
