import 'dart:convert';

import 'package:cpaysdk_flutter_plugin/track_data.dart';

class SwipeCardEvent {
  String? name;
  TrackData? trackData;
  num? errorCode;

  SwipeCardEvent();

  SwipeCardEvent.fromJson(Map json) {
    name = json['name'] as String?;
    if(json['trackData']!=null){
      trackData = TrackData.fromJson(json['trackData']  as Map);
    }
    errorCode = json['errorCode'] as num?;
  }

  Map<String, dynamic> toJson() => <String,dynamic>{
        "name": this.name,
        "trackData": this.trackData,
        "errorCode": this.errorCode,
      };
}
