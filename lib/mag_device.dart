// import 'dart:io';
// import 'dart:typed_data';

// import 'package:cpaysdk_flutter_plugin/track_data.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/services/platform_channel.dart';

// class MagDevice {
//   // 单例公开访问点
//   factory MagDevice(MethodChannel _channel) => _sharedInstance(_channel);

//   // 静态私有成员，没有初始化
//   static MagDevice _instance;

//   // 私有构造函数
//   MagDevice._(MethodChannel _channel) {
//     // 具体初始化代码
//     this._channel = _channel;
//   }

//   // 静态、同步、私有访问点
//   static MagDevice _sharedInstance(MethodChannel _channel) {
//     if (_instance == null) {
//       _instance = MagDevice._(_channel);
//     }
//     return _instance;
//   }

//   MethodChannel _channel;

//   Function onSwipeCardTimeout;
//   Function(int) onSwipeCardException;
//   Function(TrackData) onSwipeCardSuccess;
//   Function onSwipeCardFail;
//   Function onCancelSwipeCard;

//   Future<void> swipeCard(
//       int timeout,
//       bool beep,
//       Function onSwipeCardTimeout,
//       Function(int) onSwipeCardException,
//       Function(TrackData) onSwipeCardSuccess,
//       Function onSwipeCardFail,
//       Function onCancelSwipeCard) async {
//     this.onSwipeCardTimeout = onSwipeCardTimeout;
//     this.onSwipeCardException = onSwipeCardException;
//     this.onSwipeCardSuccess = onSwipeCardSuccess;
//     this.onSwipeCardFail = onSwipeCardFail;
//     this.onCancelSwipeCard = onCancelSwipeCard;
//     _channel.invokeMethod('swipeCard', {"timeout": timeout, "beep": beep});
//   }

//   Future<void> stopSwipeCard() async {
//     this.onSwipeCardTimeout = null;
//     this.onSwipeCardException = null;
//     this.onSwipeCardSuccess = null;
//     this.onSwipeCardFail = null;
//     this.onCancelSwipeCard = null;
//     return await _channel.invokeMethod('stopSwipeCard');
//   }
// }
