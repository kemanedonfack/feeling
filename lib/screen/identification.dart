import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import '../controllers/facebook._login_controller.dart';
import '../localization/language_constants.dart';
import 'package:feeling/controllers/google_login_controller.dart';

import '../utile/utile.dart';
import 'verification.dart';

class PhoneIdentificationScreen extends StatefulWidget {
  const PhoneIdentificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneIdentificationScreenState createState() =>
      _PhoneIdentificationScreenState();
}

class _PhoneIdentificationScreenState extends State<PhoneIdentificationScreen> {
  Utilisateurs utilisateurs = Utilisateurs(
    nom: '',
    idutilisateurs: 'idutilisateurs',
    interet: ['interet'],
    age: 20,
    numero: '690',
    pays: 'pays',
    photo: ['photo'],
    profession: 'profession',
    sexe: 'sexe',
    ville: 'ville',
    propos: 'propos',
    online: false,
    email: "",
    etablissement: "",
    token: '',
  );
  final _formKey = GlobalKey<FormState>();

  final phonecontroller = TextEditingController();
  GoogleSignInController googleSignIn = GoogleSignInController();
  FacebookSignInController facebookSignin = FacebookSignInController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  late String verificationId;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.08),
                  Text(getTranslated(context, 'mon_numero'),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.07)),
                  SizedBox(height: size.height * 0.01),
                  Text(getTranslated(context, 'entrer_numero_valid'),
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: size.width * 0.04)),
                  SizedBox(height: size.height * 0.04),
                  TextFormField(
                    // keyboardType: TextInputType.number,
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'entrer_numero'),
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value) {
                      if (value!.isNotEmpty) {
                        // RegExp regex = RegExp(r"^6[957][0-9]{7}$");
                        // if(!regex.hasMatch(value)){
                        //   return getTranslated(context,'invalid_numero');
                        // }else{
                        //   return null;
                        // }
                        return null;
                      } else {
                        return getTranslated(context, 'entrer_numero');
                      }
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                  // Text("NB: Nous sommes disponible uniquement au cameroun",
                  // textAlign: TextAlign.left, style: TextStyle( fontSize: size.width*0.04, fontWeight: FontWeight.bold)),
                  // SizedBox(height: size.height*0.03),
                  loading ? 
                    Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: size.width,
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                  color: Colors.white),
                            ),
                          ),
                        )
                      : Material(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Theme.of(context).primaryColor,
                          child: MaterialButton(
                            minWidth: size.width,
                            onPressed: () async {
                              if(await tryConnection() == true){
                                verifyPhoneNumbe();
                              }else{
                                connection();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                getTranslated(context, 'btn_continue'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.width * 0.05,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(height: size.height * 0.2),
                  InkWell(
                    onTap: () {
                      signInWithGoogle();
                    },
                    child: Center(
                      child: Container(
                        width: size.width * 0.9,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                                width: size.width * 0.1,
                                child: Image.asset("images/g.png")),
                            SizedBox(width: 10),
                            Text(
                                "${getTranslated(context, 'inscription_avec')} Google")
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  InkWell(
                    onTap: () {
                      signInWithFacebook();
                    },
                    child: Container(
                      width: size.width * 0.9,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xff3A5898),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 5,
                              spreadRadius: 2),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                              width: size.width * 0.1,
                              child: Image.asset("images/f.png")),
                          SizedBox(width: 10),
                          Text(
                            "${getTranslated(context, 'inscription_avec')} Facebook ",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),

                  // SizedBox(height: size.height*0.03),
                  // Center(
                  //   child: InkWell(
                  //     child: Text("Ajouter mon pays dans feeling", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),)
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signInWithGoogle() async {
    User? user;

    user = await googleSignIn.login();

    if (user != null) {
      utilisateurs.nom = user.displayName!;
      utilisateurs.email = user.email!;
      utilisateurs.idutilisateurs = user.uid;
      Navigator.pushNamed(context, monSexRoute, arguments: utilisateurs);
    }
  }

  void signInWithFacebook() async {
    // facebookSignin.userData =
    User? user = await facebookSignin.login();

    if (user != null) {
      utilisateurs.nom = user.displayName ?? "";
      utilisateurs.email = user.email ?? "";
      utilisateurs.idutilisateurs = user.uid;
      Navigator.pushNamed(context, monSexRoute, arguments: utilisateurs);
    }
  }

  void verifyPhoneNumbe() async {
   
    if (_formKey.currentState!.validate()) {
       setState(() {
          loading = true;
        });
      utilisateurs.numero = phonecontroller.text;

      await _auth.verifyPhoneNumber(
        phoneNumber: phonecontroller.text,
        verificationCompleted: (phoneAuthCredential) async {
          // signInWithPhoneAuthCredential(phoneAuthCredential);
        },
        verificationFailed: (verificationFailed) async {
          setState(() {
          loading = false;
        });
          print('erreur ${verificationFailed.message}');
          // _scaffoldKey.currentState.showSnackBar(
          //   SnackBar(content: Text(verificationFailed.message as String))
          // );
        },
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            this.verificationId = verificationId;

            loading = false;

            Navigator.pushNamed(context, verificationRoute,
                arguments: ({
                  'utilisateurs': utilisateurs,
                  'verificationId': verificationId
                }));
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    }
  }

  Future<void> connection(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'erreur_internet')),
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
