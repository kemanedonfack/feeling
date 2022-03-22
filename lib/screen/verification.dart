import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../localization/language_constants.dart';

class VerificationScreen extends StatefulWidget {
  final Map<String, dynamic> utilisateursVerificationId;
  const VerificationScreen(this.utilisateursVerificationId);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController pinotpcontroller = TextEditingController();
  FocusNode pinotpfocus = FocusNode();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final BoxDecoration pinotpdecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black));
  String code = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration pinotpdecorationselect = BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Theme.of(context).primaryColor, width: 2));

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
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 15),
                      child: Icon(Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor,
                          size: MediaQuery.of(context).size.width * 0.06),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.1,
                ),
                Center(
                    child: Text(getTranslated(context, "saisir_code"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.055))),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
                PinPut(
                  fieldsCount: 6,
                  textStyle: TextStyle(
                      fontSize: 25.0, color: Theme.of(context).primaryColor),
                  eachFieldWidth: MediaQuery.of(context).size.width * 0.13,
                  eachFieldHeight: MediaQuery.of(context).size.height * 0.1,
                  focusNode: pinotpfocus,
                  controller: pinotpcontroller,
                  submittedFieldDecoration: pinotpdecorationselect,
                  selectedFieldDecoration: pinotpdecorationselect,
                  followingFieldDecoration: pinotpdecoration,
                  pinAnimationType: PinAnimationType.rotation,
                  onChanged: (pin) async {
                    setState(() {
                      code = pin;
                    });
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.18,
                ),
                loading
                    ? Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          ),
                        ),
                      )
                    : Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () {
                            verification();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              getTranslated(context, "btn_envoyer"),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  verification() {
    if (pinotpcontroller.text.length == 6) {
      setState(() {
        loading = true;
      });

      PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
          verificationId: widget.utilisateursVerificationId['verificationId'],
          smsCode: pinotpcontroller.text);
      signInWithPhoneAuthCredential(phoneAuthCredential);
    } else {
      erreurOtp();
    }
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        widget.utilisateursVerificationId['utilisateurs'].idutilisateurs =
            authCredential.user!.uid;

        setState(() {
          loading = false;
        });

        Navigator.pushNamed(context, monSexRoute,
            arguments: widget.utilisateursVerificationId['utilisateurs']);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });
      erreurCode();
    }
  }

  Future<void> erreurOtp() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(getTranslated(context, "title_erreur")),
            content: Text(
                " ${getTranslated(context, "veiller_entrer_code")} ${widget.utilisateursVerificationId['utilisateurs'].numero}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }

  Future<void> erreurCode() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(getTranslated(context, "title_erreur")),
            content: Text("Code incorrect"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }
}
