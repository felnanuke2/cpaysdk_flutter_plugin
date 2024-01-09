
import 'package:flutter/services.dart';

class SerialPortParams {
  String TAG_CHECK_BITS = "TAG_CHECK_BITS";
  String TAG_DATA_BITS = "TAG_DATA_BITS";
  int CHECK_BITS_NONE = 0;
  int CHECK_BITS_ODD = 1;
  int CHECK_BITS_EVEN = 2;
  int CHECK_BITS_MARK = 3;
  int CHECK_BITS_SPACE = 4;
  int DATA_BITS_8 = 8;
  int DATA_BITS_7 = 7;
  int DATA_BITS_6 = 6;
  int DATA_BITS_5 = 5;
}