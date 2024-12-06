namespace api.Exceptions
{
    public class MqttException : Exception
    {
        public MqttException(string message) : base(message) { }
    }
}
