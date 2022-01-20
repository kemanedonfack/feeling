import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerificationScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const VerificationScreen(this.utilisateurs, {Key? key}) : super(key: key);  

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {

  TextEditingController pinotpcontroller = TextEditingController();
  FocusNode pinotpfocus = FocusNode();


  final BoxDecoration pinotpdecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10.0),
    border: Border.all(
      color: Colors.black
    )
  );
  String code="";

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final BoxDecoration pinotpdecorationselect = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Theme.of(context).primaryColor, width: 2
      )
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.06),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.width*0.1,
                // ),
                // Center(
                //   child: Text("Vérification" , style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.055))
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.1,
                ),
                Center(
                  child: Text("Saisissez le code de vérification que nous vous avons envoyé", textAlign: TextAlign.center , style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.055))
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.15,
                ),
      
                PinPut(
                  fieldsCount: 6,
                  textStyle: TextStyle(fontSize: 25.0, color: Theme.of(context).primaryColor),
                  eachFieldWidth: MediaQuery.of(context).size.width*0.13,
                  eachFieldHeight: MediaQuery.of(context).size.height*0.1,
                  focusNode: pinotpfocus,
                  controller: pinotpcontroller,
                  submittedFieldDecoration: pinotpdecorationselect,
                  selectedFieldDecoration: pinotpdecorationselect,
                  followingFieldDecoration: pinotpdecoration,
                  pinAnimationType: PinAnimationType.rotation,
                  onChanged: (pin) async{
                    setState(() {
                      code = pin;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width*0.18,
                ),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {  
                        verification();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Envoyé",
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      //   child: Material(
      //     borderRadius: BorderRadius.circular(10.0),
      //     color: Theme.of(context).primaryColor ,
      //       child: MaterialButton(
      //         minWidth: MediaQuery.of(context).size.width,
      //         onPressed: () {  
      //           verification();
      //         },
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text("Envoyé",
      //             style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ),
      //     ),
      // ),
    );
  }
  
  verification(){
    if (kDebugMode) {
      print("code $code");
    } 

    if(pinotpcontroller.text.length==6){

      Navigator.pushNamed(context, monSexRoute, arguments: widget.utilisateurs);
    }else{
      
      erreurOtp();
    }

  }

  Future<void> erreurOtp(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: Text("Veuillez entrer le code à 6 chiffres envoyé pas sms au ${widget.utilisateurs.numero}"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        }
    );
  }


}


