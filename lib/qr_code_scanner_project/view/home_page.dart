import 'package:flutter/material.dart';
import 'package:flutter_projects/RazorPaymentGateway/RazorPaymentGateway.dart';
import 'package:flutter_projects/custom_alert_dialog/alert_dialog_page.dart';
import 'package:flutter_projects/language_translator/view/language_translator.dart';
import 'package:flutter_projects/pagination/pagination_screen.dart';
import 'package:flutter_projects/pic_in_picture/pic_in_picture.dart';
import 'package:flutter_projects/qr_code_scanner_project/view/generate_qr_code.dart';
import 'package:flutter_projects/qr_code_scanner_project/view/scan_qr_code.dart';
import 'package:flutter_projects/statusbar/status_bar.dart';
import 'package:flutter_projects/weather_project/view/WeatherHomePage.dart';
import 'package:flutter_projects/weather_project/view/home/home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Flutter Projects',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'QR code Scanner and Generator :',
                style: TextStyle(
                  color: Colors.blueAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GenerateQrCode()),
                  );
                },
                icon: Icon(Icons.qr_code_scanner),
                label: Text('Scan QR Code'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScanQrCode()),
                  );
                },
                icon: Icon(Icons.qr_code),
                label: Text('Generate QR Code'),
              ),
              SizedBox(height: 30),
              Text(
                'Language Translator :',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LanguageTranslator()),
                  );
                },
                icon: Icon(Icons.language),
                label: Text('Language Translator'),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RazorPaymentGateway()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('RazorPay PaymentGateway'),
              ),

              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlertDialogPage()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('AlertDialogPage'),
              ),

              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('PIPView'),
              ),

              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('PIPView'),
              ),


              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaginationScreen()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('Pagination Screen'),
              ),


              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WeatherHomePage()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('Weather Screen'),
              ),



              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HideStatusBarPage()),
                  );
                },
                icon: Icon(Icons.payment),
                label: Text('Hide StatusBar Page'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
