
// import 'package:flutter/services.dart';

// class MifareDevice {
//   factory MifareDevice(MethodChannel _channel) => _sharedInstance(_channel);
//   static MifareDevice _instance;
//   MethodChannel _channel;

//   MifareDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static MifareDevice _sharedInstance(MethodChannel channel) {
//     if (_instance == null) {
//       _instance = MifareDevice._(channel);
//     }
//     return _instance;
//   }

//   Future<int> auth(
//       int type, int blockaddr, List<num> keydata, List<num> resetRes) async {
//     return await _channel.invokeMethod('mifareAurh', {
//       'type': type,
//       'blockaddr': blockaddr,
//       'keydata': keydata,
//       'resetRes': resetRes
//     });
//   }

//   Future<int> readBlock(int blockaddr, List<num> data) async {
//     return await _channel
//         .invokeMethod('mifareReadBlock', {'blockaddr': blockaddr, 'data': data});
//   }

//   Future<int> writeBlock(int blockaddr, List<num> data) async {
//     return await _channel
//         .invokeMethod('mifareWriteBlock', {'blockaddr': blockaddr, 'data': data});
//   }

//   Future<List<num>> reset() async {
//     return await _channel.invokeMethod('mifareReset');
//   }

//   Future<bool> exists() async {
//     return await _channel.invokeMethod('mifareExists');
//   }

//   Future<List<num>> readM1Storage(int blockaddr) async {
//     return await _channel
//         .invokeMethod('mifareReadM1Storage', {'blockaddr': blockaddr});
//   }

//   Future<void> writeM1Storage(int blockaddr, int data) async {
//     await _channel
//         .invokeMethod('mifareWriteM1Storage', {'blockaddr': blockaddr, 'data': data});
//   }

//   Future<int> makeValue(int blockaddr, List<num> data) async {
//     return await _channel
//         .invokeMethod('mifareMakeValue', {'blockaddr': blockaddr, 'data': data});
//   }

//   Future<int> addValuePure(int blockaddr, List<num> data) async {
//     return await _channel
//         .invokeMethod('mifareAddValuePure', {'blockaddr': blockaddr, 'data': data});
//   }

//   Future<int> reduceValuePure(int blockaddr, List<num> data) async {
//     return await _channel.invokeMethod(
//         'mifareReduceValuePure', {'blockaddr': blockaddr, 'data': data});
//   }
// }
