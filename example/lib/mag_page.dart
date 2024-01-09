// import 'dart:typed_data';

// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';

// class MagCardPage extends StatefulWidget {
//   @override
//   _MagCardPageState createState() => _MagCardPageState();
// }

// class _MagCardPageState extends State<MagCardPage> {
//   String _tip = 'Nothing';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Container(
//           child: new Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Container(
//                 width: 200.0,
//                 child: CustomScrollView(
//                   physics: BouncingScrollPhysics(),
//                   reverse: true,
//                   slivers: [
//                     SliverPadding(
//                       padding: EdgeInsets.only(left: 0, right: 0),
//                       sliver: SliverList(
//                         delegate: SliverChildListDelegate([
//                           Container(
//                             child: Text(
//                               '$_tip',
//                               softWrap: true,
//                               maxLines: 1000,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           )
//                         ]),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               new Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _swipeCard,
//                       child: Text('swipeCard')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _stopSwipeCard,
//                       child: Text('stopSwipeCard')),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<void> _swipeCard() async {
//     setState(() {
//       _tip = "start swipe card";
//     });
//     await CpaysdkFlutterPlugin.magCard.swipeCard(
//         20000,
//         true,
//         () => {
//               setState(() {
//                 _tip = "Swipe Card Timeout";
//               })
//             },
//         (err) => {
//               setState(() {
//                 _tip = "Swipe Card Exception:$err";
//               })
//             },
//         (track) => {
//               setState(() {
//                 _tip = "find msg card:${track.cardno}";
//               })
//             },
//         () => {
//               setState(() {
//                 _tip = "Swipe Card Fail";
//               })
//             },
//         () => {
//               setState(() {
//                 _tip = "Cancel Swipe Card";
//               })
//             });
//   }

//   Future<void> _stopSwipeCard() async {
//     await CpaysdkFlutterPlugin.magCard.stopSwipeCard();
//     setState(() {
//       _tip = "stop success";
//     });
//   }
// }
