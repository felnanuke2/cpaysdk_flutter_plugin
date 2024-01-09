
// import 'package:flutter/services.dart';

// class LedDevice {
//   factory LedDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static LedDevice _instance;
//   MethodChannel _channel;

//   LedDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static LedDevice _sharedInstance(MethodChannel channel) {
//     if (_instance == null) {
//       _instance = LedDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<void> turnOn(int color) async {
//     await _channel.invokeMethod('turnOn', {"color": color});
//   }

//   Future<void> turnOff(int color) async {
//     await _channel.invokeMethod('turnOff', {"color": color});
//   }
// }
