// import 'dart:typed_data';

// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';

// class RfCardPage extends StatefulWidget {
//   @override
//   _RfCardPageState createState() => _RfCardPageState();
// }

// class _RfCardPageState extends State<RfCardPage> {
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
//                       onPressed: _halt,
//                       child: Text('halt')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _readCardType,
//                       child: Text('read CardType')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _reset,
//                       child: Text('reset')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _send,
//                       child: Text('send APDU')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _exists,
//                       child: Text('exists')),
//                   new MaterialButton(
//                       minWidth: 150,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _resetCard,
//                       child: Text('reset Card')),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<void> _halt() async {
//     await CpaysdkFlutterPlugin.rfCard.halt();
//     setState(() {
//       _tip = "halt success";
//     });
//   }

//   Future<void> _readCardType() async {
//     int result = await CpaysdkFlutterPlugin.rfCard.readCardType();
//     setState(() {
//       _tip = "result:$result";
//     });
//   }

//   Future<void> _reset() async {
//     List<num> result = await CpaysdkFlutterPlugin.rfCard.reset();
//     setState(() {
//       _tip = result.toString();
//     });
//   }

//   Future<void> _send() async {
//     List<num> result = await CpaysdkFlutterPlugin.rfCard.send([1,2,3,4,5]);
//     setState(() {
//       _tip = result.toString();
//     });
//   }

//   Future<void> _exists() async {
//     bool result = await CpaysdkFlutterPlugin.rfCard.exists();
//     setState(() {
//       _tip = "exist?$result";
//     });
//   }

//   Future<void> _resetCard() async {
//     List<num> result = await CpaysdkFlutterPlugin.rfCard.resetCard(0);
//     setState(() {
//       _tip = result.toString();
//     });
//   }
// }
