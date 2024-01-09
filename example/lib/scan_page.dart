

// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';

// class ScanPage extends StatefulWidget {
//   @override
//   _ScanPageState createState() => _ScanPageState();

// }

// class _ScanPageState extends State<ScanPage> {
//   String _tip = 'Nothing';

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Plugin example app'),
//       ),
//       body: Container(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 200.0,
//               child: CustomScrollView(
//                 physics: BouncingScrollPhysics(),
//                 reverse: true,
//                 slivers: [
//                   SliverPadding(
//                     padding: EdgeInsets.only(left: 0, right: 0),
//                     sliver: SliverList(
//                       delegate: SliverChildListDelegate([
//                         Container(
//                           child: Text(
//                             '$_tip',
//                             softWrap: true,
//                             maxLines: 1000,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         )
//                       ]),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 MaterialButton(
//                   minWidth: 150,
//                   onPressed: _scan,
//                   color: Colors.blue,
//                   textColor: Colors.white,
//                   child: Text('scan'),
//                 ),
//                 MaterialButton(
//                   minWidth: 150,
//                   onPressed: _autoStopScan,
//                   color: Colors.blue,
//                   textColor: Colors.white,
//                   child: Text('autoStopScan'),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );

//   }


//   Future<void> _scan() async {
//     setState(() {
//       _tip = "Start scan";
//     });

//     await CpaysdkFlutterPlugin.scan.scan(
//         (scanCode)=>{
//           setState(() {
//             _tip = 'Scan success: $scanCode';
//           })
//         },
//         (errorMsg, errorCode)=>{
//           setState(() {
//             _tip = 'Scan failed:$errorCode($errorMsg)';
//           })
//         });
//   }

//   Future<void> _autoStopScan() async {
//     setState(() {
//       _tip = "start scanning and will be stoped 5s later.";
//     });

//     await CpaysdkFlutterPlugin.scan.autoStopScan(
//             (scanCode)=>{
//           setState(() {
//             _tip = 'Scan success: $scanCode';
//           })
//         },
//             (errorMsg, errorCode)=>{
//           setState(() {
//             _tip = 'Scan failed:$errorCode($errorMsg)';
//           })
//         });
//   }
// }