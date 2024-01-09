import 'package:cpaysdk_flutter_plugin/print_item_align.dart';

class TextPrintItem {
  String? content;
  String? itemAlign = PrintItemAlign.LEFT;
  String? typefacePath;
  String? letterAndNumberTypefacePath;
  bool? underLine;
  double scaleWidth = 1.0;
  double scaleHeight = 1.0;
  bool bold;
  int marginLeft;
  int textSize = 24;
  bool isItalic;
  bool isStrikeThruText;
  int lineSpace = 4;

  TextPrintItem(
      {this.content,
      this.itemAlign,
      this.typefacePath,
      this.letterAndNumberTypefacePath,
      this.underLine,
      this.scaleWidth = 1.0,
      this.scaleHeight = 1.0,
      this.bold = false,
      this.marginLeft = 0,
      this.textSize = 24,
      this.isItalic = false,
      this.isStrikeThruText = false,
      this.lineSpace = 4});

  TextPrintItem.fromJson(Map<String, dynamic> json)
      : content = json['content'] as String?,
        itemAlign = json['itemAlign'] as String?,
        typefacePath = json['typefacePath'] as String?,
        letterAndNumberTypefacePath =
            json['letterAndNumberTypefacePath'] as String?,
        underLine = json['underLine'] == true,
        scaleWidth = json['scaleWidth'] as double,
        scaleHeight = json['scaleHeight'] as double,
        bold = json['bold'] == true,
        marginLeft = json['marginLeft'] as int,
        textSize = json['textSize'] as int,
        isItalic = json['isItalic'] == true,
        isStrikeThruText = json['isStrikeThruText'] == true,
        lineSpace = json['lineSpace'] as int;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "content": this.content,
        "itemAlign": this.itemAlign,
        "typefacePath": this.typefacePath,
        "letterAndNumberTypefacePath": this.letterAndNumberTypefacePath,
        "underLine": this.underLine,
        "scaleWidth": this.scaleWidth,
        "scaleHeight": this.scaleHeight,
        "bold": this.bold,
        "marginLeft": this.marginLeft,
        "textSize": this.textSize,
        "isItalic": this.isItalic,
        "isStrikeThruText": this.isStrikeThruText,
        "lineSpace": this.lineSpace,
      };
}
