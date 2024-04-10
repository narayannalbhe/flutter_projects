import 'package:flutter/material.dart';

class AlertDialogPage extends StatefulWidget {
  const AlertDialogPage({super.key});

  @override
  State<AlertDialogPage> createState() => _AlertDialogPageState();
}

class _AlertDialogPageState extends State<AlertDialogPage> {
  Future<void> showAlertDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title: Text(
              'Simple Alert Dialog',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    'Welcome to Geeks for Geeks',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Alert DialogBox'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            ElevatedButton(
                onPressed: () {
                  showAlertDialog();
                },
                style: ElevatedButton.styleFrom(primary: Colors.green),
                child: Text('Display Simple Alert Dialog')),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.green
              ),
                onPressed: () {
                 showDialog(context: context, builder: (BuildContext context){
                   return CustomAlertDialog();
                 });
                }, child: Text('Display Custom Alert Dialog')),
          ],
        ),
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10,70,10,10),
              child: Column(
                children: [
                  Text('Welcom to Geeks of Geeks',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),),
                  SizedBox(height: 15,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      }, 
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      child: Text('Ok',style: TextStyle(
                         color: Colors.white
                      ),))
                ],
              ),
            ),
          ),
          Positioned(
              top: -60,
              child: CircleAvatar(
                  backgroundColor: Colors.cyan,
                  child: Image.network(
                    'https://www.pexels.com/photo/brown-hummingbird-selective-focus-photography-1133957/',
                    height: 50,width: 50,)) )
        ],
      ),
    );
  }
}

