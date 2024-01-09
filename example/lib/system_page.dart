// import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
// import 'package:flutter/material.dart';

// class SystemPage extends StatefulWidget {
//   @override
//   _SystemPageState createState() => _SystemPageState();
// }

// class _SystemPageState extends State<SystemPage> {
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
//                 width: 150.0,
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
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _getInet4Address,
//                       child: Text('getInet4Addr')),
//                   new MaterialButton(
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _getHardwareAddress,
//                       child: Text('getHardwareAddr')),
//                   new MaterialButton(
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _getEthInet4Address,
//                       child: Text('getEthInet4Addr')),
//                   new MaterialButton(
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _getEthHardwareAddress,
//                       child: Text('getEthHardwareAddr')),
//                   new MaterialButton(
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _install,
//                       child: Text('install')),
//                   new MaterialButton(
//                       minWidth: 200,
//                       color: Colors.blue,
//                       textColor: Colors.white,
//                       onPressed: _uninstall,
//                       child: Text('uninstall')),
//                 ],
//               ),
//             ],
//           ),
//         ));
//   }

//   Future<void> _getInet4Address() async {
//     String ip = await CpaysdkFlutterPlugin.system.getInet4Address();
//     print(ip);
//     setState(() {
//       _tip = ip;
//     });
//   }

//   Future<void> _getHardwareAddress() async {
//     String ip = await CpaysdkFlutterPlugin.system.getHardwareAddress();
//     print(ip);
//     setState(() {
//       _tip = ip;
//     });
//   }

//   Future<void> _getEthInet4Address() async {
//     String ip = await CpaysdkFlutterPlugin.system.getEthInet4Address();
//     print(ip);
//     setState(() {
//       _tip = ip;
//     });
//   }

//   Future<void> _getEthHardwareAddress() async {
//     String ip = await CpaysdkFlutterPlugin.system.getEthHardwareAddress();
//     print(ip);
//     setState(() {
//       _tip = ip;
//     });
//   }

//   Future<void> _install() async {
//     String result = await CpaysdkFlutterPlugin.system.install("path");
//     print(result);
//     setState(() {
//       _tip = result;
//     });
//   }

//   Future<void> _uninstall() async {
//     String result = await CpaysdkFlutterPlugin.system.uninstall("pkgName");
//     print(result);
//     setState(() {
//       _tip = result;
//     });
//   }
// }
