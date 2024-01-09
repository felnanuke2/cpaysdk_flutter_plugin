import 'package:cpaysdk_flutter_plugin/print_item_align.dart';

class QRCodePrintItemParam {
  String mQRCode = "";
  int mQrWidth = 0;
  int mErrorCorrectingLevel = 2;
  String mItemAlign = PrintItemAlign.LEFT;

  QRCodePrintItemParam();

  QRCodePrintItemParam.fromJson(Map<String, dynamic> json)
      : mQRCode = json['mQRCode'] as String,
        mQrWidth = json['mQrWidth'] as int,
        mErrorCorrectingLevel = json['mErrorCorrectingLevel'] as int,
        mItemAlign = json['mItemAlign'] as String;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "mQRCode": this.mQRCode,
        "mQrWidth": this.mQrWidth,
        "mErrorCorrectingLevel": this.mErrorCorrectingLevel,
        "mItemAlign": this.mItemAlign,
      };
}
