import 'package:cpaysdk_flutter_plugin/track_data.dart';
import 'package:flutter/services.dart';

import 'emv_trans_param.dart';

typedef _OnFindMagCard = void Function(TrackData);
typedef _OnFindICCard = void Function();
typedef _OnFindRFCard = void Function();
typedef _OnFindError = void Function(int, String);

typedef _onRequestAmount = void Function(int);
typedef _onRequestAccount = void Function();
typedef _onRequestTipsConfirm = void Function(String, String);
typedef _onRequestAidSelect = void Function(List<String>);
typedef _onRequestEcashTipsConfirm = void Function();
typedef _onConfirmCardInfo = void Function(String);
typedef _onRequestPin = void Function(bool, String);
typedef _onRequestUserAuth = void Function(int, String);
typedef _onRequestVoiceTipConfirm = void Function();
typedef _onConfirmFinalSelect = void Function(String);
typedef _onSignatureRequest = void Function();
typedef _onCvmFlagVerify = void Function();
typedef _onRequestOnline = void Function();
typedef _onTransResult = void Function(ByteData, String);
typedef _onError = void Function(int, String);

class EmvDevice {
  static late EmvDevice _instance;
  late MethodChannel _channel;

  _onRequestAmount? onRequestAmount;
  _onRequestAccount? onRequestAccount;
  _onRequestTipsConfirm? onRequestTipsConfirm;
  _onRequestAidSelect? onRequestAidSelect;
  _onRequestEcashTipsConfirm? onRequestEcashTipsConfirm;
  _onConfirmCardInfo? onConfirmCardInfo;
  _onRequestPin? onRequestPin;
  _onRequestUserAuth? onRequestUserAuth;
  _onRequestVoiceTipConfirm? onRequestVoiceTipConfirm;
  _onConfirmFinalSelect? onConfirmFinalSelect;
  _onSignatureRequest? onSignatureRequest;
  _onCvmFlagVerify? onCvmFlagVerify;
  _onRequestOnline? onRequestOnline;
  _OnFindMagCard? onFindMagCard;
  _OnFindICCard? onFindICCard;
  _OnFindRFCard? onFindRFCard;
  _OnFindError? onFindError;
  _onTransResult? onTransResult;
  _onError? onError;

  factory EmvDevice(MethodChannel _channel) => _sharedInstance(_channel);

  EmvDevice._(MethodChannel _channel) {
    this._channel = _channel;
  }

  static EmvDevice _sharedInstance(MethodChannel _channel) {
    if (_instance == null) {
      _instance = EmvDevice._(_channel);
    }
    return _instance;
  }

  Future<void> checkCard(
      _OnFindMagCard onFindMagCard,
      _OnFindICCard onFindICCard,
      _OnFindRFCard onFindRFCard,
      _OnFindError onFindError) async {
    this.onFindMagCard = onFindMagCard;
    this.onFindICCard = onFindICCard;
    this.onFindRFCard = onFindRFCard;
    this.onFindError = onFindError;
    await _channel.invokeMethod<dynamic>('checkCard');
  }

  Future<void> stopCheckCard() async {
    await _channel.invokeMethod<dynamic>('stopCheckCard');
  }

  Future<void> processEmv(
      int flow,
      bool forceOnline,
      Uint8List tlv,
      _onRequestAmount onRequestAmount,
      _onRequestAccount onRequestAccount,
      _onRequestTipsConfirm onRequestTipsConfirm,
      _onRequestAidSelect onRequestAidSelect,
      _onRequestEcashTipsConfirm onRequestEcashTipsConfirm,
      _onConfirmCardInfo onConfirmCardInfo,
      _onRequestPin onRequestPin,
      _onRequestUserAuth onRequestUserAuth,
      _onRequestVoiceTipConfirm onRequestVoiceTipConfirm,
      _onConfirmFinalSelect onConfirmFinalSelect,
      _onSignatureRequest onSignatureRequest,
      _onCvmFlagVerify onCvmFlagVerify,
      _onRequestOnline onRequestOnline,
      _onTransResult onTransResult,
      _onError onError) async {
    this.onRequestAmount = onRequestAmount;
    this.onRequestAccount = onRequestAccount;
    this.onRequestTipsConfirm = onRequestTipsConfirm;
    this.onRequestAidSelect = onRequestAidSelect;
    this.onRequestEcashTipsConfirm = onRequestEcashTipsConfirm;
    this.onConfirmCardInfo = onConfirmCardInfo;
    this.onRequestPin = onRequestPin;
    this.onRequestUserAuth = onRequestUserAuth;
    this.onRequestVoiceTipConfirm = onRequestVoiceTipConfirm;
    this.onConfirmFinalSelect = onConfirmFinalSelect;
    this.onSignatureRequest = onSignatureRequest;
    this.onCvmFlagVerify = onCvmFlagVerify;
    this.onRequestOnline = onRequestOnline;
    this.onTransResult = onTransResult;
    this.onError = onError;
    await _channel.invokeMethod<dynamic>('processEmv',
        {"emv_flow": flow, "force_online": forceOnline, "tlv_bytes": tlv});
  }

  Future<void> abortEmv() async {
    await _channel.invokeMethod<dynamic>("abortEmv");
  }

  Future<void> clearKernelICTransLog() async {
    await _channel.invokeMethod<dynamic>("clearKernelICTransLog");
  }

  Future<bool> importAmount(String amount) async {
    return await _channel.invokeMethod<bool?>(
        "emvImportAmount", {"amount": amount}).then((value) => value == true);
  }

  Future<bool> importAccountType(int type) async {
    return await _channel.invokeMethod<bool>(
        "emvImportAccountType", {"type": type}).then((value) => value == true);
  }

  Future<bool> importAidSelectRes(int index) async {
    return await _channel.invokeMethod<bool>("emvImportAidSelectRes",
        {"index": index}).then((value) => value == true);
  }

  Future<bool> importIssuerVoiceReference(int res) async {
    return await _channel.invokeMethod<bool>("emvImportIssuerVoiceReference",
        {"res": res}).then((value) => value == true);
  }

  Future<bool> importConfirmCardInfoRes(bool res) async {
    return await _channel.invokeMethod<bool>("emvImportConfirmCardInfoRes",
        {"res": res}).then((value) => value == true);
  }

  Future<bool> importPin(bool isOnlinePin, String pin) async {
    return await _channel.invokeMethod<bool>("emvImportPin", {
      "isOnlinePin": isOnlinePin,
      "pin": pin
    }).then((value) => value == true);
  }

  Future<bool> importUserAuthRes(bool res) async {
    return await _channel.invokeMethod<bool>(
        "emvImportUserAuthRes", {"res": res}).then((value) => value == true);
  }

  Future<bool> importMsgConfirmRes(bool res) async {
    return await _channel.invokeMethod<bool>(
        "emvImportMsgConfirmRes", {"res": res}).then((value) => value == true);
  }

  Future<bool> importECashTipConfirmRes(bool res) async {
    return await _channel.invokeMethod<bool>("emvImportECashTipConfirmRes",
        {"res": res}).then((value) => value == true);
  }

  Future<bool> importOnlineResp(
      bool onlineRes, String respCode, String icData55) async {
    return await _channel.invokeMethod<bool>("emvImportOnlineResp", {
      "onlineRes": onlineRes,
      "respCode": respCode,
      "icData55": icData55
    }).then((value) => value == true);
  }

  Future<bool> importResultOfSignatureRequest(bool res) async {
    return await _channel.invokeMethod<bool>(
        "emvImportResultOfSignatureRequest",
        {"res": res}).then((value) => value == true);
  }

  Future<bool> importResultOfCvmFlagVerify(bool res) async {
    return await _channel.invokeMethod<bool>("emvImportResultOfCvmFlagVerify",
        {"res": res}).then((value) => value == true);
  }

  Future<bool> importFinalAidConfigsSelect(bool res, String params) async {
    return await _channel.invokeMethod<bool>("emvImportFinalAidConfigsSelect",
        {"res": res, "params": params}).then((value) => value == true);
  }

  Future<bool> updateAID(int optFlag, String aid) async {
    return await _channel.invokeMethod<bool>("emvUpdateAID",
        {"optFlag": optFlag, "aid": aid}).then((value) => value == true);
  }

  Future<bool> updateCAPK(int optFlag, String capk) async {
    return await _channel.invokeMethod<bool>("emvUpdateCAPK",
        {"optFlag": optFlag, "capk": capk}).then((value) => value == true);
  }

  Future<String> readEmvKernelData(List<String> tagLists) async {
    return await _channel.invokeMethod<String>("emvReadEmvKernelData",
        {"tagLists": tagLists}).then((value) => value ?? 'undefined');
  }
}
