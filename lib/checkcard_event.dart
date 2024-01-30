// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'track_data.dart';

class CheckCardEvent {
  String? name;
  TrackData? trackData; // You'll need to define a TrackData class in Dart
  num? errorCode;
  String? errorMsg;
  CheckCardEvent({
    this.name,
    this.trackData,
    this.errorCode,
    this.errorMsg,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'trackData': trackData?.toJson(),
      'errorCode': errorCode,
      'errorMsg': errorMsg,
    };
  }

  factory CheckCardEvent.fromMap(Map map) {
    return CheckCardEvent(
      name: map['name'] != null ? map['name'] as String : null,
      trackData: map['trackData'] != null ? TrackData.fromJson(map['trackData'] as Map) : null,
      errorCode: map['errorCode'] != null ? map['errorCode'] as num : null,
      errorMsg: map['errorMsg'] != null ? map['errorMsg'] as String : null,
    );
  }

 
}
