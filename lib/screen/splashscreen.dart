import 'dart:async';

import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  initState(){
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Image.asset("images/logo2.png", fit: BoxFit.cover)
          ),
        ),
    );
  }

  startTime() async {
    var duration = const Duration(seconds: 5);
    return  Timer(duration, (() => Navigator.pushReplacementNamed(context, welcomeRoute) ));
  }
  
}


