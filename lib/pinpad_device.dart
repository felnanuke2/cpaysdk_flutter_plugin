// import 'dart:convert';

// // import 'package:cpaysdk_flutter_plugin/key_type.dart';
// import 'package:cpaysdk_flutter_plugin/pin_pad_info.dart';
// import 'package:flutter/services.dart';

// class PinpadDevice {
//   MethodChannel _channel;
//   static PinpadDevice _instance;

//   PinpadDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   factory PinpadDevice(MethodChannel _channel) => _shareInstance(_channel);

//   static PinpadDevice _shareInstance(MethodChannel _channel) {
//     if (_instance == null) {
//       _instance = PinpadDevice._(_channel);
//     }
//     return _instance;
//   }

//   Future<bool> loadTek(int tekId, List<num> data, List<num> checkValue) async {
//     if (checkValue == null) {
//       return await _channel
//           .invokeMethod('loadTek', {'tek_id': tekId, 'tek': data});
//     } else {
//       return await _channel.invokeMethod(
//           'loadTek', {'tek_id': tekId, 'tek': data, 'check_value': checkValue});
//     }
//   }

//   Future<bool> loadTmk(
//       int tekId, int tmkId, List<num> data, List<num> checkValue) async {
//     if (checkValue == null) {
//       return await _channel.invokeMethod(
//           'loadTmk', {'tek_id': tekId, 'tmk_id': tmkId, 'tmk': data});
//     } else {
//       return await _channel.invokeMethod('loadTmk', {
//         'tek_id': tekId,
//         'tmk_id': tmkId,
//         'tmk': data,
//         'check_value': checkValue
//       });
//     }
//   }

//   Future<bool> loadPik(
//       int tmkId, int pikId, List<num> data, List<num> checkValue) async {
//     if (checkValue == null) {
//       return await _channel.invokeMethod(
//           'loadPik', {'tmk_id': tmkId, 'pik_id': pikId, 'pik': data});
//     } else {
//       return await _channel.invokeMethod('loadPik', {
//         'tmk_id': tmkId,
//         'pik_id': pikId,
//         'pik': data,
//         'check_value': checkValue
//       });
//     }
//   }

//   Future<bool> loadMak(
//       int tmkId, int makId, List<num> data, List<num> checkValue) async {
//     if (checkValue == null) {
//       return await _channel.invokeMethod(
//           'loadMak', {'tmk_id': tmkId, 'mak_id': makId, 'mak': data});
//     } else {
//       return await _channel.invokeMethod('loadMak', {
//         'tmk_id': tmkId,
//         'mak_id': makId,
//         'mak': data,
//         'check_value': checkValue
//       });
//     }
//   }

//   Future<bool> loadTdk(
//       int tmkId, int tdkId, List<num> data, List<num> checkValue) async {
//     if (checkValue == null) {
//       return await _channel.invokeMethod('loadTdk', {
//         'tmk_id': tmkId,
//         'tdk_id': tdkId,
//         'tdk': data,
//       });
//     } else {
//       return await _channel.invokeMethod('loadTdk', {
//         'tmk_id': tmkId,
//         'tdk_id': tdkId,
//         'tdk': data,
//         'check_value': checkValue
//       });
//     }
//   }

//   Future<bool> loadTmkPlant(int tmkId, List<num> data) async {
//     return await _channel
//         .invokeMethod('loadTmkPlant', {'tmk_id': tmkId, 'tmk': data});
//   }

//   Function(int, String) onReadingPin;
//   Function onReadPinCancel;
//   Function(String) onReadPinSuccess;
//   Function(int, String) onError;

//   Future<void> getPin(
//       FlutterPinInfo pinInfo,
//       Function(int, String) onReadingPin,
//       Function onReadPinCancel,
//       Function(String) onReadPinSuccess,
//       Function(int, String) onError) async {
//     this.onReadingPin = onReadingPin;
//     this.onReadPinCancel = onReadPinCancel;
//     this.onReadPinSuccess = onReadPinSuccess;
//     this.onError = onError;


//     await _channel.invokeMethod("getPinBlock", {'pinInfo': jsonEncode(pinInfo)});
//   }

//   Future<String> getMac(
//       int macType, String data, int macMode, int makId) async {
//     return await _channel.invokeMethod("getMac", {
//       "mac_type": macType,
//       "data": data,
//       "mac_mode": macMode,
//       "mak_id": makId
//     });
//   }

//   Future<String> getEncData(String data, bool isCbcMode, int tdkId) async {
//     return await _channel.invokeMethod(
//         "getEncData", {"data": data, "mode": isCbcMode, "tdk_id": tdkId});
//   }

//   Future<String> getDecryptedData(
//       String data, bool isCbcMode, int tdkId) async {
//     return await _channel.invokeMethod(
//         "getDecryptedData", {"data": data, "mode": isCbcMode, "tdk_id": tdkId});
//   }

//   Future<String> getRandom() async {
//     return await _channel.invokeMethod("getRandom");
//   }

//   Future<String> getCheckValue(int keyType, int keyId) async {
//     return await _channel
//         .invokeMethod("getCheckValue", {"key_type": keyType, "key_id": keyId});
//   }
// }
