
import 'package:cpaysdk_flutter_plugin/text_print_item.dart';

class MultipleTextPrintItemParam {
  List<double> scale = [];
  List<TextPrintItem> mTextPrintItemParam = [];

  MultipleTextPrintItemParam();

  MultipleTextPrintItemParam.fromJson(Map<String, dynamic> json)
      : scale = json['scale'] as List<double>,
        mTextPrintItemParam =
            json['mTextPrintItemParam'] as List<TextPrintItem>;

  Map<String, dynamic> toJson() => <String, dynamic>{
        "scale": this.scale,
        "mTextPrintItemParam": this.mTextPrintItemParam,
      };
}
