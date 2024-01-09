import 'dart:convert';

import 'package:cpaysdk_flutter_plugin/multi_text_print_item.dart';
import 'package:cpaysdk_flutter_plugin/printer_state.dart';
import 'package:cpaysdk_flutter_plugin/qrcode_print_item.dart';
import 'package:cpaysdk_flutter_plugin/text_print_item.dart';
import 'package:flutter/services.dart';

import 'barcode_print_item.dart';
import 'bitmap_print_item.dart';

class PrinterDevice {
  late MethodChannel _channel;

  PrinterDevice(this._channel);

  Future<int> getPrinterState() async {
    final int result =
        await _channel.invokeMethod<int>('getPrinterState') ?? -1;
    return result;
  }

  Future<void> setPrinterGray(int gray) async {
    await _channel.invokeMethod<dynamic>('setPrinterGray', {"gray": gray});
  }

  Future<void> addTextPrintItem(TextPrintItem printItem) async {
    await _channel.invokeMethod<dynamic>(
        'addTextPrintItem', {"text": jsonEncode(printItem)});
  }

  Future<void> addMultipleTextPrintItem(
      MultipleTextPrintItemParam printItem) async {
    await _channel.invokeMethod<dynamic>(
        'addMultipleTextPrintItem', {"textList": jsonEncode(printItem)});
  }

  Future<void> addBarCodePrintItem(BarCodePrintItemParam printItem) async {
    await _channel.invokeMethod<dynamic>(
        'addBarCodePrintItem', {"barcode": jsonEncode(printItem)});
  }

  Future<void> addBitmapPrintItem(BitmapPrintItemParam printItem) async {
    await _channel.invokeMethod<dynamic>(
        'addBitmapPrintItem', {"bitmap": jsonEncode(printItem)});
  }

  Future<void> addQrPrintItemParam(QRCodePrintItemParam printItem) async {
    await _channel.invokeMethod<dynamic>(
        'addQrPrintItemParam', {"qrcode": jsonEncode(printItem)});
  }

  Future<void> clearBufferArea() async {
    await _channel.invokeMethod<dynamic>('clearBufferArea');
  }

  Future<PrintState> printSync() async {
    final String? result = await _channel.invokeMethod<String>('printSync');
    print("打印结果：" + (result ?? ''));
    if (result != null) {
      final PrintState state = PrintState.fromJson(
          Map<String, dynamic>.from(jsonDecode(result) as Map));
      print("code：" + state.stateCode.toString());
      print("msg：" + state.stateMsg);
      return state;
    }
    return PrintState(stateCode: -1, stateMsg: 'Undefined');
  }
}
