import 'package:flutter/material.dart';
import 'package:flutter_projects/qr_code_scanner_project/view/generate_qr_code.dart';
import 'package:flutter_projects/qr_code_scanner_project/view/scan_qr_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR code Scanner and Generator'),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return GenerateQrCode();
                  })) ;
                });
              },
              child: Text(
            'Scan QR Code '
          )),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return ScanQrCode();
                  })) ;
                });
              },
              child: Text(
                  'Generate QR Code '
              )),
        ],
      ),
    );
  }
}
