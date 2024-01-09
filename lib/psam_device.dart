
// import 'package:flutter/services.dart';

// class PsamDevice {
//   factory PsamDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static PsamDevice _instance;
//   MethodChannel _channel;

//   PsamDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static PsamDevice _sharedInstance(MethodChannel channel) {
//     if (_instance == null) {
//       _instance = PsamDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<List<num>> reset() async {
//     return await _channel.invokeMethod('psamReset');
//   }

//   Future<List<num>> sendApdu(List<num> apdu) async {
//     return await _channel.invokeMethod('psamSendApdu', {'apdu':apdu});
//   }

//   Future<bool> setETU(int etu) async {
//     return await _channel.invokeMethod('psamSetETU',{'etu':etu});
//   }

//   Future<int> setCLK(int clk) async {
//     return await _channel.invokeMethod('psamSetCLK',{'clk':clk});
//   }
// }
