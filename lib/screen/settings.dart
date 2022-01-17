import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: Icon(Icons.close),
        title: Text("Paramètres ", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}