


// import 'dart:io';

// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// class BeepPage extends StatefulWidget {
//   @override
//   _BeepPageState createState() => _BeepPageState();

// }

// class _BeepPageState extends State<BeepPage> {
//   String _tip = 'Nothing';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plugin example app'),
//       ),
//       body: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Container(
//               child: Expanded(child: Text('$_tip'),),
//             ),
//             MaterialButton(
//               color: Colors.blue,
//               textColor: Colors.white,
//               onPressed: _beep,
//               child: Text('Beep'),
//             )
//           ],
//         ),
//       ),
//     );
//   }


//   Future<void> _beep() async{
//     CpaysdkFlutterPlugin.beep.beep(0);
//     sleep(Duration(seconds: 1));
//     CpaysdkFlutterPlugin.beep.beep(1);
//     sleep(Duration(seconds: 1));
//     CpaysdkFlutterPlugin.beep.beep(2);
//     setState(() {
//       _tip = "beep";
//     });
//   }
// }
