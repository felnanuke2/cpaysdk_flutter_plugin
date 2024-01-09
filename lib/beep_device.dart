
import 'package:flutter/services.dart';

class BeepDevice {

  factory BeepDevice(MethodChannel _channel) => _sharedInstance(_channel);
  static  BeepDevice? _instance;
  MethodChannel? _channel;

  BeepDevice._(MethodChannel _channel) {
    this._channel = _channel;
  }

  static BeepDevice _sharedInstance(MethodChannel channel) {
    if(_instance == null) {
      _instance = BeepDevice._(channel);
    }
    return _instance!;
  }

  Future<void> beep(int type) async {
    await _channel!.invokeMethod<dynamic>('beep',{"type": type});
  }
}