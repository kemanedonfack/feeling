import 'package:feeling/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);


  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset("images/bg3.jpg", fit: BoxFit.cover,)
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
            color: Colors.black.withOpacity(0.85),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: size.width*0.5,
                      height: size.height*0.15,
                      child: Image.asset("images/logo.png")
                    ),
                    SizedBox(height: size.height*0.01),
                    Text(getTranslated(context, 'app_description'), textAlign: TextAlign.center, 
                      style: TextStyle(color: Colors.white, fontSize: size.width*0.047),),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius:BorderRadius.circular(9),
                        color: Colors.white10,
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () { Navigator.pushNamed(context, phoneidenficationRoute); },
                        child: Text(getTranslated(context, 'btn_inscription'),
                          style: TextStyle(color: Colors.white, fontSize: size.width*0.05, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius:BorderRadius.circular(9),
                        color: Colors.white,
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        onPressed: () { Navigator.pushNamed(context, phoneidenficationRoute); },
                        child: Text(getTranslated(context, 'btn_connexion'),
                          style: TextStyle(color: Colors.black, fontSize: size.width*0.05, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height*0.03),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(getTranslated(context, 'politique'), textAlign: TextAlign.center, 
                        style: TextStyle(color: Colors.white, fontSize: size.width*0.04),),
                    ),
                  ],
                ),
                
              ],
            ),
          )

        ],
      ),
    );
  }
}




