
import 'package:flutter/material.dart';

class successfullogin extends StatefulWidget {
  const successfullogin({Key? key}) : super(key: key);

  @override
  State<successfullogin> createState() => _successfulloginState();
}

class _successfulloginState extends State<successfullogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('successfullogin',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
      ),
    );
  }
}
