import 'package:flutter/material.dart';


class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);


  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Text("Choississez votre langue préférée", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.06)
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Text("Svp choississez une langue", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04)
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                      child: Image.asset('images/fr.png', fit: BoxFit.cover)
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
                    ),
                    Text("Français", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04)
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.03,
                      child: Image.asset('images/en.png', fit: BoxFit.cover)
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.05,
                    ),
                    Text("English", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04)
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Divider(color: Colors.grey),
              ),
            ],
          ),
        )
      ),
      
    );
  }
}

