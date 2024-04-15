import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/SignInPage.dart';
import 'package:flutter_projects/qr_code_scanner_project/view/home_page.dart';
import 'package:flutter_projects/task_management/view/TaskHomePage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //     const SystemUiOverlayStyle(
    //         statusBarColor: Colors.transparent,
    //         statusBarIconBrightness: Brightness.dark
    //     )
    // );
    return MaterialApp(
      title: 'QR Code Scanner and Generator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: const HomePage(),
//      home: const SignInPage(),
      // home: const TaskHomePage(),
    );
  }
}

