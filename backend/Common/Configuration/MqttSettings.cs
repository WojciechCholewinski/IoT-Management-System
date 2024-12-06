namespace Common.Configuration
{
    public class MqttSettings
    {
        public string ClientId { get; set; }
        public string Broker { get; set; }
        public string MqttUsername { get; set; }
        public string MqttPassword { get; set; }
        public int Port { get; set; }
        public bool CleanSession { get; set; }
    }

}
