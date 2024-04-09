import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQrCode extends StatefulWidget {
  const ScanQrCode({super.key});

  @override
  State<ScanQrCode> createState() => _ScanQrCodeState();
}

class _ScanQrCodeState extends State<ScanQrCode> {
  String qrResult = 'Scanned data will appear here';
  String qrData = '';

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
      });
    } on PlatformException {
      qrResult = 'Failed to read QR code';
    }
  }

  void generateQRCode(String data) {
    setState(() {
      qrData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            qrData.isNotEmpty
                ? QrImage(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            )
                : Text(qrResult),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: scanQR,
              child: Text('Scan Code'),
            ),
            ElevatedButton(
              onPressed: () {
                generateQRCode('Your QR code data here');
              },
              child: Text('Scan QR Code'),
            ),
          ],
        ),
      ),
    );
  }
}
