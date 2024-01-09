// import 'dart:io';
// import 'dart:typed_data';

// import 'package:flutter/src/services/platform_channel.dart';

// class RfDevice {
//   MethodChannel _channel;

//   // 单例公开访问点
//   factory RfDevice(MethodChannel _channel) => _sharedInstance(_channel);

//   // 静态私有成员，没有初始化
//   static RfDevice _instance;

//   // 私有构造函数
//   RfDevice._(MethodChannel _channel) {
//     // 具体初始化代码
//     this._channel = _channel;
//   }

//   // 静态、同步、私有访问点
//   static RfDevice _sharedInstance(MethodChannel _channel) {
//     if (_instance == null) {
//       _instance = RfDevice._(_channel);
//     }
//     return _instance;
//   }

//   Future<void> halt() async {
//     await _channel.invokeMethod('rfHalt');
//   }

//   Future<int> readCardType() async {
//     return await _channel.invokeMethod('readCardType');
//   }

//   Future<List<num>> reset() async {
//     return await _channel.invokeMethod('rfReset');
//   }

//   Future<List<num>> send(List<num> data) async {
//     return await _channel.invokeMethod('rfSend', {"data": data});
//   }

//   Future<bool> exists() async {
//     return await _channel.invokeMethod('rfExists');
//   }

//   Future<List<num>> resetCard(int cardType) async {
//     return await _channel.invokeMethod('resetCard', {"cardType": cardType});
//   }
// }
