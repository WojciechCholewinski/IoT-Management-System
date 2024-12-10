using DailyResetFunction;
using Common.Configuration;
using Common.Entities;
using Common.Services;
using Microsoft.Azure.Functions.Worker.Builder;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var builder = FunctionsApplication.CreateBuilder(args);

builder.ConfigureFunctionsWebApplication();

// Pobierz katalog roboczy projektu
var basePath = AppContext.BaseDirectory; // U?ywamy AppContext.BaseDirectory jako bardziej niezawodnego ?ród?a
var commonConfigPath = Path.GetFullPath(Path.Combine(basePath, "../../../../../Common/Configuration/appsettings.common.json"));

// Sprawd?, czy plik istnieje
if (!File.Exists(commonConfigPath))
{
    throw new FileNotFoundException($"Configuration file not found at: {commonConfigPath}");
}

// Dodaj konfiguracj?
builder.Configuration
    .SetBasePath(Path.GetDirectoryName(commonConfigPath)!) // Ustawiamy katalog zawieraj?cy plik
    .AddJsonFile(commonConfigPath, optional: true, reloadOnChange: true)
    .AddEnvironmentVariables();

var configuration = builder.Configuration;

// Konfiguracja reszty us?ug
var connectionString = configuration.GetConnectionString("DefaultConnection");

if (string.IsNullOrEmpty(connectionString))
{
    throw new InvalidOperationException("DefaultConnection is not configured.");
}

builder.Services.AddDbContext<IoT_DbContext>(options =>
{
    options.UseSqlServer(connectionString);
});

builder.Services.Configure<MqttSettings>(
    configuration.GetSection("MqttSettings"));

builder.Services.AddAutoMapper(AppDomain.CurrentDomain.GetAssemblies());
builder.Services.AddScoped<IAutomationService, AutomationService>();
builder.Services.AddSingleton<IMqttService, MqttService>();
builder.Services.AddScoped<ResetFunction>();

builder.Logging.AddConsole();
builder.Build().Run();
