import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = 'scanned Data will Appear here';

  Future<void> scanQR() async{
    try{
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
           '#ff6666','cancel',true, ScanMode.QR);
      if(!mounted)return;
      setState(() {
        this.qrResult = qrCode.toString();
      });
    }on PlatformException{
      qrResult = 'Fail to read Qr code';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 30,),
          Text(qrResult,style: TextStyle(

          ),),
          SizedBox(height: 10,),
          ElevatedButton(
              onPressed: (){

              },
              child: Text('Scan Code'))
        ],
      ),
    );
  }
}
