using api.Middleware;
using Common.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using MQTTnet;
using MQTTnet.Client;
using System.Text;

namespace Common.Services
{

    public class MqttService : IMqttService
    {
        private readonly IMqttClient _mqttClient;
        private readonly MqttClientOptions _mqttOptions;
        private readonly ILogger<ErrorHandlingMiddleware> _logger;
        private MqttSettings _mqttSettings;

        public MqttService(IOptions<MqttSettings> mqttSettings, ILogger<ErrorHandlingMiddleware> logger)
        {
            _mqttSettings = mqttSettings?.Value ?? throw new ArgumentNullException(nameof(mqttSettings));

            var settings = mqttSettings.Value;
            var mqttFactory = new MqttFactory();
            _mqttClient = mqttFactory.CreateMqttClient();
            _logger = logger;

            if (string.IsNullOrEmpty(_mqttSettings.Broker))
            {
                throw new ArgumentException($"MqttSettings.Broker is null or empty. Current settings: {System.Text.Json.JsonSerializer.Serialize(_mqttSettings)}");
            }

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
                _logger.LogInformation($"Disconnected from MQTT Broker. Reason: {e.Reason}");
                _logger.LogInformation($"Disconnected from MQTT Broker. ReasonString: {e.ReasonString}");

                if (e.Reason == MqttClientDisconnectReason.KeepAliveTimeout ||
                    e.Reason == MqttClientDisconnectReason.ServerBusy)
                {
                    await Task.Delay(TimeSpan.FromSeconds(5));
                    try
                    {
                        await _mqttClient.ConnectAsync(_mqttOptions);
                    }
                    catch (Exception ex)
                    {
                        _logger.LogError($"Reconnect failed: {ex.Message}");
                    }
                }
                else
                {
                    _logger.LogWarning($"Unexpected disconnection reason: {e.Reason}. No reconnection attempt.");
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
