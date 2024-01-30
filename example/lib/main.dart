import 'package:cpaysdk_flutter_plugin_example/beep_page.dart';
import 'package:cpaysdk_flutter_plugin_example/emv_page.dart';

import 'package:cpaysdk_flutter_plugin_example/ic_page.dart';
import 'package:cpaysdk_flutter_plugin_example/mag_page.dart';

import 'package:cpaysdk_flutter_plugin_example/print_page.dart';
import 'package:cpaysdk_flutter_plugin_example/rf_page.dart';
import 'package:cpaysdk_flutter_plugin_example/scan_page.dart';
import 'package:cpaysdk_flutter_plugin_example/system_page.dart';
import 'package:flutter/material.dart';

// import 'led_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(new MaterialApp(
    title: 'Plugin example app',
    home: new App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('First Screen'),
      ),
      body: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            new MaterialButton(
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Printer Device'),
              onPressed: () {
                // Navigate to second screen when tapped!
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                      builder: (context) => PrinterPage()),
                );
              },
            ),
            new MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    new MaterialPageRoute<dynamic>(
                        builder: (context) => new IcCardPage()),
                  );
                },
                child: Text('IC Device')),
            new MaterialButton(
                color: Colors.blue,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push<dynamic>(
                    context,
                    new MaterialPageRoute<dynamic>(
                        builder: (context) => new EmvPage()),
                  );
                },
                child: Text('Emv Device')),
            // new MaterialButton(
            //     color: Colors.blue,
            //     textColor: Colors.white,
            //     onPressed: () {
            //       Navigator.push<dynamic>(
            //         context,
            //         new MaterialPageRoute<dynamic>(
            //             builder: (context) => new RfCardPage()),
            //       );
            //     },
            //     child: Text('RF Device')),
            // new MaterialButton(
            //     color: Colors.blue,
            //     textColor: Colors.white,
            //     onPressed: () {
            //       Navigator.push<dynamic>(
            //         context,
            //         new MaterialPageRoute<dynamic>(
            //             builder: (context) => new SystemPage()),
            //       );
            //     },
            //     child: Text('System Device')),
            // new MaterialButton(
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   onPressed: () {
            //     Navigator.push<dynamic>(
            //         context,
            //         new MaterialPageRoute<dynamic>(
            //             builder: (context) => BeepPage()));
            //   },
            //   child: Text('Beep Device'),
            // ),
            // new MaterialButton(
            //   onPressed: () {
            //     Navigator.push<dynamic>(
            //         context,
            //         new MaterialPageRoute<dynamic>(
            //             builder: (context) => ScanPage()));
            //   },
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   child: Text('Scan Device'),
            // ),
            // new MaterialButton(
            //   onPressed: () {
            //     Navigator.push<dynamic>(
            //         context,
            //         new MaterialPageRoute<dynamic>(
            //             builder: (context) => MagCardPage()));
            //   },
            //   color: Colors.blue,
            //   textColor: Colors.white,
            //   child: Text('Magnetic Card Device'),
            // )
          ],
        ),
      ),
    );
  }
}
