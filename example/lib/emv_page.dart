import 'package:cpaysdk_flutter_plugin/cpaysdk_flutter_plugin.dart';
import 'package:cpaysdk_flutter_plugin/track_data.dart';
import 'package:flutter/material.dart';

class EmvPage extends StatefulWidget {
  const EmvPage({Key? key}) : super(key: key);

  @override
  State<EmvPage> createState() => _EmvPageState();
}

class _EmvPageState extends State<EmvPage> {
  final emv = CpaysdkFlutterPlugin.emvDevice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _checkCard,
            child: Text(
              'Check Card',
            ),
          ),
          ElevatedButton(
            onPressed: _stopCheckCard,
            child: Text(
              'Stop Check Card',
            ),
          )
        ],
      ),
    );
  }

  void _checkCard() {
    emv.checkCard(
      _onFindMagCard,
      _findIcCard,
      _onFindRfCard,
      _onFindError,
    );
  }

  void _onFindMagCard(TrackData data) {
    print("find Card");
    print(data.cardno);
    print(data.expiryDate);
    print(data.serviceCode);
  }

  void _onFindError(int p1, String p2) {
    print("find error");
    print(p1);
    print(p2);
  }

  void _findIcCard() {
    print("find ic card");
  }

  void _onFindRfCard() {
    print("find rf card");
  }

  void _stopCheckCard() {}
}
