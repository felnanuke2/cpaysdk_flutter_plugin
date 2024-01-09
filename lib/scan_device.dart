
// import 'package:flutter/services.dart';

// class ScanDevice {
//   MethodChannel _methodChannel;
//   static ScanDevice _instance;
  
//   Function(String) onScanSuccess;
//   Function(String, int) onScanFailed;
  
//   ScanDevice._(MethodChannel _channel) {
//     _methodChannel = _channel;
//   }
//   factory ScanDevice(MethodChannel _channel) => _shareInstance(_channel);

//   static ScanDevice _shareInstance(MethodChannel _channel) {
//     if(_instance == null) {
//       _instance = ScanDevice._(_channel);
//     }
//     return _instance;
//   }
  
//   Future<void> scan(Function(String) onScanSuccess, Function(String, int) onScanFailed) {
//     this.onScanSuccess = onScanSuccess;
//     this.onScanFailed = onScanFailed;
//     _methodChannel.invokeMethod('scan');
//   }

//   Future<void> autoStopScan(Function(String) onScanSuccess, Function(String, int) onScanFailed) {
//     this.onScanSuccess = onScanSuccess;
//     this.onScanFailed = onScanFailed;
//     _methodChannel.invokeMethod('autoStopScan');
//   }
// }