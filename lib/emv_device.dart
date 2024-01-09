// import 'dart:ffi';
// import 'dart:typed_data';

// import 'package:cpaysdk_flutter_plugin/track_data.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'emv_trans_param.dart';

// typedef _OnFindMagCard = Function(TrackData);
// typedef _OnFindICCard = Function();
// typedef _OnFindRFCard = Function();
// typedef _OnFindError = Function(int, String);

// typedef _onRequestAmount = Function(int);
// typedef _onRequestAccount = Function();
// typedef _onRequestTipsConfirm = Function(String, String);
// typedef _onRequestAidSelect = Function(List<String>);
// typedef _onRequestEcashTipsConfirm = Function();
// typedef _onConfirmCardInfo = Function(String);
// typedef _onRequestPin = Function(bool, String);
// typedef _onRequestUserAuth = Function(int, String);
// typedef _onRequestVoiceTipConfirm = Function();
// typedef _onConfirmFinalSelect = Function(String);
// typedef _onSignatureRequest = Function();
// typedef _onCvmFlagVerify = Function();
// typedef _onRequestOnline = Function();
// typedef _onTransResult = Function(ByteData, String);
// typedef _onError = Function(int, String);

// class EmvDevice {
//   static EmvDevice _instance;
//   MethodChannel _channel;

//   _onRequestAmount onRequestAmount;
//   _onRequestAccount onRequestAccount;
//   _onRequestTipsConfirm onRequestTipsConfirm;
//   _onRequestAidSelect onRequestAidSelect;
//   _onRequestEcashTipsConfirm onRequestEcashTipsConfirm;
//   _onConfirmCardInfo onConfirmCardInfo;
//   _onRequestPin onRequestPin;
//   _onRequestUserAuth onRequestUserAuth;
//   _onRequestVoiceTipConfirm onRequestVoiceTipConfirm;
//   _onConfirmFinalSelect onConfirmFinalSelect;
//   _onSignatureRequest onSignatureRequest;
//   _onCvmFlagVerify onCvmFlagVerify;
//   _onRequestOnline onRequestOnline;
//   _OnFindMagCard onFindMagCard;
//   _OnFindICCard onFindICCard;
//   _OnFindRFCard onFindRFCard;
//   _OnFindError onFindError;


//   _onTransResult onTransResult;
//   _onError onError;

//   factory EmvDevice(MethodChannel _channel) => _sharedInstance(_channel);

//   EmvDevice._(MethodChannel _channel) {
//     this._channel = _channel;
//   }

//   static EmvDevice _sharedInstance(MethodChannel _channel) {
//     if (_instance == null) {
//       _instance = EmvDevice._(_channel);
//     }
//     return _instance;
//   }

//   Future<void> checkCard(
//       _OnFindMagCard onFindMagCard,
//       _OnFindICCard onFindICCard,
//       _OnFindRFCard onFindRFCard,
//       _OnFindError onFindError) async {
//     this.onFindMagCard = onFindMagCard;
//     this.onFindICCard = onFindICCard;
//     this.onFindRFCard = onFindRFCard;
//     this.onFindError = onFindError;
//     await _channel.invokeMethod('checkCard');
//   }

//   Future<void> stopCheckCard() async {
//     await _channel.invokeMethod('stopCheckCard');
//   }

//   Future<void> processEmv(
//       int flow,
//       bool forceOnline,
//       Uint8List tlv,
//       _onRequestAmount onRequestAmount,
//       _onRequestAccount onRequestAccount,
//       _onRequestTipsConfirm onRequestTipsConfirm,
//       _onRequestAidSelect onRequestAidSelect,
//       _onRequestEcashTipsConfirm onRequestEcashTipsConfirm,
//       _onConfirmCardInfo onConfirmCardInfo,
//       _onRequestPin onRequestPin,
//       _onRequestUserAuth onRequestUserAuth,
//       _onRequestVoiceTipConfirm onRequestVoiceTipConfirm,
//       _onConfirmFinalSelect onConfirmFinalSelect,
//       _onSignatureRequest onSignatureRequest,
//       _onCvmFlagVerify onCvmFlagVerify,
//       _onRequestOnline onRequestOnline,
//       _onTransResult onTransResult,
//       _onError onError) async {
//     this.onRequestAmount = onRequestAmount;
//     this.onRequestAccount = onRequestAccount;
//     this.onRequestTipsConfirm = onRequestTipsConfirm;
//     this.onRequestAidSelect = onRequestAidSelect;
//     this.onRequestEcashTipsConfirm = onRequestEcashTipsConfirm;
//     this.onConfirmCardInfo = onConfirmCardInfo;
//     this.onRequestPin = onRequestPin;
//     this.onRequestUserAuth = onRequestUserAuth;
//     this.onRequestVoiceTipConfirm = onRequestVoiceTipConfirm;
//     this.onConfirmFinalSelect = onConfirmFinalSelect;
//     this.onSignatureRequest = onSignatureRequest;
//     this.onCvmFlagVerify = onCvmFlagVerify;
//     this.onRequestOnline = onRequestOnline;
//     this.onTransResult = onTransResult;
//     this.onError = onError;
//     await _channel.invokeMethod('processEmv',
//         {"emv_flow": flow, "force_online": forceOnline, "tlv_bytes": tlv});
//   }

//   Future<void> abortEmv() async {
//     await _channel.invokeMethod("abortEmv");
//   }

//   Future<void> clearKernelICTransLog() async {
//     await _channel.invokeMethod("clearKernelICTransLog");
//   }

//   Future<bool> importAmount(String amount) async {
//     return await _channel.invokeMethod("emvImportAmount", {"amount":amount});
//   }

//   Future<bool> importAccountType(int type) async {
//     return await _channel.invokeMethod("emvImportAccountType", {"type":type});
//   }

//   Future<bool> importAidSelectRes(int index) async {
//     return await _channel.invokeMethod("emvImportAidSelectRes", {"index":index});
//   }

//   Future<bool> importIssuerVoiceReference(int res) async {
//     return await _channel.invokeMethod("emvImportIssuerVoiceReference", {"res":res});
//   }

//   Future<bool> importConfirmCardInfoRes(bool res) async {
//     return await _channel.invokeMethod("emvImportConfirmCardInfoRes", {"res":res});
//   }

//   Future<bool> importPin(bool isOnlinePin, String pin) async {
//     return await _channel.invokeMethod("emvImportPin", {"isOnlinePin":isOnlinePin, "pin":pin});
//   }

//   Future<bool> importUserAuthRes(bool res) async {
//     return await _channel.invokeMethod("emvImportUserAuthRes", {"res":res});
//   }

//   Future<bool> importMsgConfirmRes(bool res) async {
//     return await _channel.invokeMethod("emvImportMsgConfirmRes", {"res":res});
//   }

//   Future<bool> importECashTipConfirmRes(bool res) async {
//     return await _channel.invokeMethod("emvImportECashTipConfirmRes", {"res":res});
//   }

//   Future<bool> importOnlineResp(bool onlineRes, String respCode, String icData55) async {
//     return await _channel.invokeMethod("emvImportOnlineResp", {"onlineRes":onlineRes, "respCode":respCode, "icData55":icData55});
//   }

//   Future<bool> importResultOfSignatureRequest(bool res) async {
//     return await _channel.invokeMethod("emvImportResultOfSignatureRequest", {"res":res});
//   }

//   Future<bool> importResultOfCvmFlagVerify(bool res) async {
//     return await _channel.invokeMethod("emvImportResultOfCvmFlagVerify", {"res":res});
//   }

//   Future<bool> importFinalAidConfigsSelect(bool res, String params) async {
//     return await _channel.invokeMethod("emvImportFinalAidConfigsSelect", {"res":res, "params":params});
//   }

//   Future<bool> updateAID(int optFlag, String aid) async {
//     return await _channel.invokeMethod("emvUpdateAID", {"optFlag":optFlag, "aid":aid});
//   }

//   Future<bool> updateCAPK(int optFlag, String capk) async {
//     return await _channel.invokeMethod("emvUpdateCAPK", {"optFlag":optFlag, "capk":capk});
//   }

//   Future<String> readEmvKernelData(List<String> tagLists) async {
//     return await _channel.invokeMethod("emvReadEmvKernelData", {"tagLists":tagLists});
//   }



// }
