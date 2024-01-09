
// import 'package:flutter/services.dart';

// import 'docker_connect_type.dart';

// class DockDevice {

//   factory DockDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static DockDevice _instance;
//   MethodChannel _channel;

//   DockDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static DockDevice _sharedInstance(MethodChannel channel) {
//     if(_instance == null) {
//       _instance = DockDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<bool> connect(DockConnectType type, int baudRate) async {
//     return await _channel.invokeMethod('dockerConnect',{'type': type, 'baudRate':baudRate});
//   }

//   Future<bool> write(List<num> data) async {
//     return await _channel.invokeMethod('dockerWrite',{'data': data});
//   }

//   Future<int> read(List<num> buffer, int timeout) async {
//     return await _channel.invokeMethod('dockerRead',{'buffer': buffer, 'timeout':timeout});
//   }

//   Future<void> clearCache() async {
//     return await _channel.invokeMethod('dockerClearCache');
//   }

//   Future<bool> disconnect() async {
//     return await _channel.invokeMethod('dockerDisconnect');
//   }
// }