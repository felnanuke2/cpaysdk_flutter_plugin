
// import 'package:flutter/services.dart';

// class SerialPortDevice {
//   factory SerialPortDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static SerialPortDevice _instance;
//   MethodChannel _channel;

//   SerialPortDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static SerialPortDevice _sharedInstance(MethodChannel channel) {
//     if (_instance == null) {
//       _instance = SerialPortDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<bool> open(int boardRate, int dataBit, int checkBit) async {
//     return await _channel.invokeMethod('open', {'boardRate':boardRate, 'TAG_DATA_BITS':dataBit, 'TAG_CHECK_BITS':checkBit});
//   }

//   Future<bool> close() async {
//     await _channel.invokeMethod('close');
//   }

//   Future<bool> sendData(List<num> data) async {
//     return await _channel.invokeMethod('sendData',{'data':data});
//   }

//   Future<int> receiveData(List<num> data, int timeout) async {
//     return await _channel.invokeMethod('receiveData',{'data':data, 'timeout':timeout});
//   }

//   Future<void> clearCache() async {
//     await _channel.invokeMethod('clearCache');
//   }
// }
