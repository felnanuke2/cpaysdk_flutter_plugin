// import 'dart:typed_data';

// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';

// class IcCardPage extends StatefulWidget {
//   @override
//   _IcCardPageState createState() => _IcCardPageState();
// }

// class _IcCardPageState extends State<IcCardPage> {
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
//               new Container(
//                 child: Expanded(child: Text("$_tip")),
//               ),
//               new Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   new MaterialButton(
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _halt,
//                       child: Text('halt')),
//                   new MaterialButton(
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _reset,
//                       child: Text('reset')),
//                   new MaterialButton(
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _send,
//                       child: Text('send')),
//                   new MaterialButton(
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _exists,
//                       child: Text('exists')),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<void> _halt() async {
//     await CpaysdkFlutterPlugin.icCard.halt();
//     setState(() {
//       _tip = "halt success";
//     });
//   }

//   Future<void> _reset() async {
//     List<num> ret = await CpaysdkFlutterPlugin.icCard.reset();
//     setState(() {
//       _tip = ret.toString();
//     });
//   }

//   Future<void> _send() async {
//     List<num> ret = await CpaysdkFlutterPlugin.icCard.send([1,2,3,4,5]);
//     setState(() {
//       _tip = ret.toString();
//     });
//   }

//   Future<bool> _exists() async {
//     bool exist = await CpaysdkFlutterPlugin.icCard.exists();
//     setState(() {
//       _tip = "exist?$exist";
//     });
//     return exist;
//   }
// }
