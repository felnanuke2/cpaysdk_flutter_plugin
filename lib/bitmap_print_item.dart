import 'dart:typed_data';

import 'package:cpaysdk_flutter_plugin/print_item_align.dart';

class BitmapPrintItemParam {
  List<num> mBitmap = [];
  String mItemAlign = PrintItemAlign.LEFT;
  int mWidth = 0;
  int mHeight = 0;

  BitmapPrintItemParam();

  BitmapPrintItemParam.fromJson(Map<String, dynamic> json)
      : mBitmap = json['mBitmap'] as List<num>,
        mItemAlign = json['PrintItemAlign'] as String,
        mWidth = json['mWidth'] as int,
        mHeight = json['mHeight'] as int;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "mBitmap": this.mBitmap,
        "mItemAlign": this.mItemAlign,
        "mWidth": this.mWidth,
        "mHeight": this.mHeight,
      };
}
