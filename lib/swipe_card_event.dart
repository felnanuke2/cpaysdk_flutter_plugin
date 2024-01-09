// import 'dart:convert';

// import 'package:cpaysdk_flutter_plugin/track_data.dart';

// class SwipeCardEvent {
//   String name;
//   TrackData trackData;
//   num errorCode;

//   SwipeCardEvent();

//   SwipeCardEvent.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     if(json['trackData']!=null){
//       trackData = TrackData.fromJson(json['trackData']);
//     }
//     errorCode = json['errorCode'];
//   }

//   Map<String, dynamic> toJson() => {
//         "name": this.name,
//         "trackData": this.trackData,
//         "errorCode": this.errorCode,
//       };
// }
