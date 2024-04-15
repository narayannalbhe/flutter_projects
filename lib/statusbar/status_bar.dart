import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HideStatusBarPage extends StatefulWidget {
  const HideStatusBarPage({Key? key}) : super(key: key);

  @override
  _HideStatusBarPageState createState() => _HideStatusBarPageState();
}

class _HideStatusBarPageState extends State<HideStatusBarPage> {
  bool isStatusBarHidden = false;

  void toggleStatusBar() {
    setState(() {
      isStatusBarHidden = !isStatusBarHidden;
    });

    if (isStatusBarHidden) {
      SystemChrome.setEnabledSystemUIOverlays([]);
    } else {
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hide StatusBar Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: toggleStatusBar,
          child: Text(isStatusBarHidden ? 'Show StatusBar' : 'Hide StatusBar'),
        ),
      ),
    );
  }
}
