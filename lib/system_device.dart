// import 'package:flutter/services.dart';

// class SystemDevice {
//   MethodChannel _channel;

//   // 单例公开访问点
//   factory SystemDevice(MethodChannel _channel) => _sharedInstance(_channel);

//   // 静态私有成员，没有初始化
//   static SystemDevice _instance;

//   // 私有构造函数
//   SystemDevice._(MethodChannel _channel) {
//     // 具体初始化代码
//     this._channel = _channel;
//   }

//   // 静态、同步、私有访问点
//   static SystemDevice _sharedInstance(MethodChannel _channel) {
//     if (_instance == null) {
//       _instance = SystemDevice._(_channel);
//     }
//     return _instance;
//   }

//   Future<String> getInet4Address() async {
//     return await _channel.invokeMethod('inet4Address');
//   }

//   Future<String> getHardwareAddress() async {
//     return await _channel.invokeMethod('hardwareAddress');
//   }

//   Future<String> getEthInet4Address() async {
//     return await _channel.invokeMethod('ethInet4Address');
//   }

//   Future<String> getEthHardwareAddress() async {
//     return await _channel.invokeMethod('ethHardwareAddress');
//   }

//   Future<void> lcdOn() async {
//     await _channel.invokeMethod('lcdOn');
//   }

//   Future<void> lcdOff() async {
//     await _channel.invokeMethod('lcdOff');
//   }

//   Future<void> reboot() async {
//     await _channel.invokeMethod('reboot');
//   }

//   Future<void> setSystemTime(String time) async {
//     await _channel.invokeMethod('setSystemTime', {"time": time});
//   }

//   Future<String> install(String path) async {
//     return await _channel.invokeMethod('install', {"path": path});
//   }

//   Future<String> uninstall(String pkgName) async {
//     return await _channel.invokeMethod('uninstall', {"package": pkgName});
//   }
// }
