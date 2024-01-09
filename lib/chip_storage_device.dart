
// import 'package:flutter/services.dart';

// class ChipStorageDevice {

//   factory ChipStorageDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static ChipStorageDevice _instance;
//   MethodChannel _channel;

//   ChipStorageDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static ChipStorageDevice _sharedInstance(MethodChannel channel) {
//     if(_instance == null) {
//       _instance = ChipStorageDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<int> write(int index, ByteData data) async {
//     return await _channel.invokeMethod('write',{"index": index, "data": data});
//   }

//   Future<ByteData> read(int index, int lenght) async {
//     return await _channel.invokeMethod('write',{"index": index, "lenght": lenght});
//   }
// }