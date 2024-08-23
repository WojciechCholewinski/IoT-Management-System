﻿using api.Models;
using Microsoft.AspNetCore.Mvc;

namespace api.Services
{
    public interface IDeviceService
    {
        IEnumerable<DeviceDto> GetAll();
        bool? UpdateIsOn(int id, bool isOn);
    }
}
