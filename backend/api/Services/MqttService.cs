using api.Exceptions;
using api.Middleware;
using Microsoft.Extensions.Options;
using MQTTnet;
using MQTTnet.Client;
using System.Text;

namespace api.Services
{

    public class MqttService : IMqttService
    {
        private readonly IMqttClient _mqttClient;
        private readonly MqttClientOptions _mqttOptions;
        private readonly ILogger<ErrorHandlingMiddleware> _logger;

        public MqttService(IOptions<MqttSettings> mqttSettings, ILogger<ErrorHandlingMiddleware> logger)
        {
            var settings = mqttSettings.Value;
            var mqttFactory = new MqttFactory();
            _mqttClient = mqttFactory.CreateMqttClient();
            _logger = logger;

            _mqttOptions = new MqttClientOptionsBuilder()
                .WithClientId(settings.ClientId)
                .WithTcpServer(settings.Broker, settings.Port)
                .WithCredentials(settings.MqttUsername, settings.MqttPassword)
                .WithTls()
                .WithCleanSession(settings.CleanSession)
                .Build();

            _mqttClient.ConnectedAsync += async e =>
            {
                _logger.LogInformation("Connected to mqtt broker.");
            };

            _mqttClient.DisconnectedAsync += async e =>
            {
                _logger.LogInformation("Disconnected from MQTT Broker.");
                await Task.Delay(TimeSpan.FromSeconds(5));
                try
                {
                    await _mqttClient.ConnectAsync(_mqttOptions);
                }
                catch
                {
                    _logger.LogInformation("Reconnect failed.");
                }
            };


            _mqttClient.ConnectAsync(_mqttOptions).Wait();
        }

        public async Task PublishMessageAsync(string topic, string payload)
        {
            var message = new MqttApplicationMessageBuilder()
                .WithTopic(topic)
                .WithPayload(Encoding.UTF8.GetBytes(payload))
                .WithQualityOfServiceLevel(MQTTnet.Protocol.MqttQualityOfServiceLevel.ExactlyOnce)
                .Build();

            if (!_mqttClient.IsConnected)
            {
                await _mqttClient.ConnectAsync(_mqttOptions);
            }

            await _mqttClient.PublishAsync(message);
            _logger.LogInformation($"PublishMessageAsync: {topic}");
        }
    }
}
