import 'package:flutter/material.dart';
import 'package:flutter_projects/language_translator/view/language_translator.dart';
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
        title: Text('Flutter Projects',style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text('QR code Scanner and Generator :',style: TextStyle(
              color: Colors.blueAccent,fontWeight: FontWeight.bold,
               fontSize: 16
            ),),
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
            SizedBox(height: 20),
            Text('Language Translator :',style: TextStyle(
                color: Colors.deepPurple,fontWeight: FontWeight.bold,
                fontSize: 16
            ),),
            ElevatedButton(
                onPressed: (){
                  setState(() {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return LanguageTranslator();
                    })) ;
                  });
                },
                child: Text(
                    'Language Translator'
                )),

          ],
        ),
      ),
    );
  }
}
