﻿namespace api.Services
{
    public interface IMqttService
    {
        Task PublishMessageAsync(string topic, string payload);
    }
}
