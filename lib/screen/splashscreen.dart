import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:shared_preferences/shared_preferences.dart';


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

    UtilisateurController utilisateurController = UtilisateurController();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if(_prefs.getBool('isBooster') == true){
        
      int now =  DateTime.now().millisecondsSinceEpoch; 
      int end = _prefs.getInt('dateToEndBooster') as int;
      if(now >= end){
        if(await tryConnection() == true){
          await utilisateurController.endBooster(_prefs.getString('idusers') as String).then((value) {
            _prefs.setBool('isBooster', false);
          });
        }

      }
      
    }

    List<Utilisateurs> listutilisateurs = [];
    DatabaseConnection connection = DatabaseConnection();
    listutilisateurs = await connection.getUtilisateurs();

    if(listutilisateurs.isEmpty){
      Navigator.pushReplacementNamed(context, chooseLanguageRoute);
    }else{
      if (kDebugMode) {
      print("splash users ${listutilisateurs[0].idutilisateurs}");
    }
      Navigator.pushReplacementNamed(context, tabRoute);
    }
    // var duration = const Duration(seconds: 5);
    // return  Timer(duration, (() =>  ));
  }
  
}


