import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Sign in with email and password
              UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: 'example@email.com',
                password: 'your_password',
              );

              // Once signed in, get the ID token
              String? idToken = await userCredential.user!.getIdToken();
              print('ID Token: $idToken');
            } catch (e) {
              print('Error: $e');
            }
          },
          child: const Text('Sign In'),
        ),
      ),
    );
  }
}