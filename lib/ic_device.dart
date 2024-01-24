
import 'package:flutter/src/services/platform_channel.dart';

class IcDevice {
 late  MethodChannel _channel;
  // 单例公开访问点
  factory IcDevice(MethodChannel _channel) => _sharedInstance(_channel);

  // 静态私有成员，没有初始化
  static IcDevice? _instance;

  // 私有构造函数
  IcDevice._(MethodChannel _channel) {
    // 具体初始化代码
    this._channel = _channel;
  }

  // 静态、同步、私有访问点
  static IcDevice _sharedInstance(MethodChannel _channel) {
    if (_instance == null) {
      _instance = IcDevice._(_channel);
    }
    return _instance!;
  }

  Future<void> halt() async {
    await _channel.invokeMethod<dynamic>('halt');
  }

  Future<List<num>?> reset() async {
    return await _channel.invokeMethod<List<num>>('reset');
  }

  Future<List<num>?> send(List<num> data) async {
    return await _channel.invokeMethod<List<num>>('send', {"data": data});
  }

  Future<bool> exists() async {
    return await _channel.invokeMethod<dynamic>('exists') ==true;
  }
}
