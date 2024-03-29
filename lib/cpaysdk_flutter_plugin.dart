import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:cpaysdk_flutter_plugin/barcode_print_item.dart';
import 'package:cpaysdk_flutter_plugin/bitmap_print_item.dart';
import 'package:cpaysdk_flutter_plugin/chip_storage_device.dart';
import 'package:cpaysdk_flutter_plugin/docker_device.dart';
import 'package:cpaysdk_flutter_plugin/emv_device.dart';
import 'package:cpaysdk_flutter_plugin/ic_device.dart';
import 'package:cpaysdk_flutter_plugin/led_device.dart';
import 'package:cpaysdk_flutter_plugin/mag_device.dart';
import 'package:cpaysdk_flutter_plugin/mifare_device.dart';
import 'package:cpaysdk_flutter_plugin/pinpad_device.dart';
import 'package:cpaysdk_flutter_plugin/pinpad_event.dart';
import 'package:cpaysdk_flutter_plugin/printer_device.dart';
import 'package:cpaysdk_flutter_plugin/psam_device.dart';
import 'package:cpaysdk_flutter_plugin/qrcode_print_item.dart';
import 'package:cpaysdk_flutter_plugin/rf_device.dart';
import 'package:cpaysdk_flutter_plugin/scan_device.dart';
import 'package:cpaysdk_flutter_plugin/scan_event.dart';
import 'package:cpaysdk_flutter_plugin/serial_port_device.dart';
import 'package:cpaysdk_flutter_plugin/swipe_card_event.dart';
import 'package:cpaysdk_flutter_plugin/system_device.dart';
import 'package:flutter/services.dart';
import 'package:cpaysdk_flutter_plugin/text_print_item.dart';
import 'package:cpaysdk_flutter_plugin/beep_device.dart';

import 'checkcard_event.dart';
import 'emv_process_event.dart';
import 'printer_state.dart';

class CpaysdkFlutterPlugin {
  static MethodChannel _channel = const MethodChannel('cpaysdk_flutter_plugin')
    ..setMethodCallHandler(_methodCallHandler);

  static Future<dynamic> _methodCallHandler(MethodCall call) async {
    print("收到回调[" + call.method + "]:" + call.arguments.toString());
    switch (call.method) {
      case 'onSwipeCardEvent':
        SwipeCardEvent event = SwipeCardEvent.fromJson(
            jsonDecode(call.arguments as String) as Map);
        print("刷卡事件名称：" + (event.name ?? ''));
        print(event.trackData);
        print(event.errorCode);
        switch (event.name) {
          case "onSwipeCardSuccess":
            print("comminin11:${event.trackData?.cardno}");
            magCard.onSwipeCardSuccess?.call(event.trackData!);
            break;
          case "onSwipeCardException":
            print("commas22");
            magCard.onSwipeCardException?.call(event.errorCode?.toInt() ?? -1);
            break;
          case "onCancelSwipeCard":
            print("commas3333");
            magCard.onCancelSwipeCard?.call();
            break;
          case "onSwipeCardTimeout":
            print("commas4444");
            magCard.onSwipeCardTimeout?.call();
            break;
          case "onSwipeCardFail":
            print("commas5555");
            print(magCard.onSwipeCardFail.hashCode);
            magCard.onSwipeCardFail?.call();
            break;
          default:
            print("I don't know");
            break;
        }
        break;
      // case 'onScanEvent':
      //   ScanEvent event = ScanEvent.fromJson(jsonDecode(call.arguments));
      //   switch (event.name) {
      //     case 'onScanSuccess':
      //       scan.onScanSuccess(event.scanCode);
      //       break;
      //     case 'onScanFailed':
      //       scan.onScanFailed(event.errorMsg, event.errorCode);
      //       break;
      //     default:
      //       break;
      //   }
      //   break;
      // case 'OnPinpadEvent':
      //   PinpadEvent event = PinpadEvent.fromJson(jsonDecode(call.arguments));
      //   switch (event.name) {
      //     case 'onReadingPin':
      //       pinpad.onReadingPin(event.len, event.inputItem);
      //       break;
      //     case 'onReadPinCancel':
      //       pinpad.onReadPinCancel();
      //       break;
      //     case 'onReadPinSuccess':
      //       pinpad.onReadPinSuccess(event.pinBlock);
      //       break;
      //     case 'onError':
      //       pinpad.onError(event.errorCode, event.errorMsg);
      //       break;
      //     default:
      //       break;
      //   }
      //   break;
      case 'CheckCardEvent':
        CheckCardEvent event =
            CheckCardEvent.fromMap(jsonDecode(call.arguments as String) as Map);
        switch (event.name) {
          case 'onFindMagCard':
            emvDevice.onFindMagCard?.call(event.trackData!);
            break;
          case 'onFindICCard':
            emvDevice.onFindICCard?.call();
            break;
          case 'onFindRFCard':
            emvDevice.onFindRFCard?.call();
            break;
          case 'onError':
            emvDevice.onFindError?.call(event.errorCode!.toInt(), event.errorMsg!);
            break;
          default:
            break;
        }
        break;
      case 'EmvProcessEvent':
        EmvProcessEvent event =
            EmvProcessEvent.fromMap(jsonDecode(call.arguments as String) as Map);
        switch (event.name) {
          case 'onRequestAmount':
            emvDevice.onRequestAmount?.call(int.parse(event.amount??''));
            break;
          case 'onRequestAccount':
            emvDevice.onRequestAccount?.call();
            break;
          case 'onRequestTipsConfirm':
            emvDevice.onRequestTipsConfirm?.call(event.tipTitle!, event.tipContent!);
            break;
          case 'onRequestAidSelect':
            emvDevice.onRequestAidSelect?.call(event.aids!);
            break;
          case 'onRequestEcashTipsConfirm':
            emvDevice.onRequestEcashTipsConfirm?.call();
            break;
          case 'onConfirmCardInfo':
            emvDevice.onConfirmCardInfo?.call(event.cardNo!);
            break;
          case 'onRequestPin':
            emvDevice.onRequestPin?.call(event.isOnlinePin!, event.amount!);
            break;
          case 'onRequestUserAuth':
            emvDevice.onRequestUserAuth?.call(event.type!, event.authContent!);
            break;
          case 'onRequestVoiceTipConfirm':
            emvDevice.onRequestVoiceTipConfirm?.call();
            break;
          case 'onConfirmFinalSelect':
            emvDevice.onConfirmFinalSelect?.call(event.finalAid!);
            break;
          case 'onSignatureRequest':
            emvDevice.onSignatureRequest?.call();
            break;
          case 'onCvmFlagVerify':
            emvDevice.onCvmFlagVerify?.call();
            break;
          case 'onRequestOnline':
            emvDevice.onRequestOnline?.call();
            break;
          case 'onTransResult':
            // emvDevice.onTransResult?.call(event.transResult!, event.resultContent);
            break;
          case 'onError':
            emvDevice.onError?.call(event.errorId!, event.errorMsg!);
            break;
          default:
            break;
        }
        break;
      default:
        print('not method.');
    }
  }

  static PrinterDevice get printer {
    return PrinterDevice(_channel);
  }

  // static SystemDevice get system {
  //   return SystemDevice(_channel);
  // }

  static IcDevice get icCard {
    return IcDevice(_channel);
  }

  // static RfDevice get rfCard {
  //   return RfDevice(_channel);
  // }

  static MagDevice get magCard {
    return MagDevice(_channel);
  }

  // static BeepDevice get beep {
  //   return BeepDevice(_channel);
  // }

  // static ScanDevice get scan {
  //   return ScanDevice(_channel);
  // }

  // static PinpadDevice get pinpad {
  //   return PinpadDevice(_channel);
  // }

  static EmvDevice get emvDevice {
    return EmvDevice(_channel);
  }

  // static ChipStorageDevice get chipSorage {
  //   return ChipStorageDevice(_channel);
  // }

  // static LedDevice get led {
  //   return LedDevice(_channel);
  // }

  // static SerialPortDevice get serialPort {
  //   return SerialPortDevice(_channel);
  // }

  // static PsamDevice get psam {
  //   return PsamDevice(_channel);
  // }

  // static MifareDevice get mifare {
  //   return MifareDevice(_channel);
  // }

  // static DockDevice get dock {
  //   return DockDevice(_channel);
  // }
}
