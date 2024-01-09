import 'package:cpaysdk_flutter_plugin/print_item_align.dart';

class BarCodePrintItemParam {
  String barcodeContent = "";
  int width = 0;
  int height = 0;
  int barcodeType = 0;
  String mItemAlign = PrintItemAlign.LEFT;

  BarCodePrintItemParam();

  BarCodePrintItemParam.fromJson(Map<String, dynamic> json)
      : barcodeContent = json['barcodeContent'] as String,
        width = json['width'] as int,
        height = json['height'] as int,
        barcodeType = json['barcodeType'] as int,
        mItemAlign = json['mItemAlign'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "barcodeContent": this.barcodeContent,
        "width": this.width,
        "height": this.height,
        "barcodeType": this.barcodeType,
        "mItemAlign": this.mItemAlign,
      };
}
