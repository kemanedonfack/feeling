// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/localization/language_constants.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? _image;
  double TWO_PI = 3.14 * 2;
  Utilisateurs utilisateursOnline = Utilisateurs(nom: 'nom', idutilisateurs: 'idutilisateurs', 
  interet: ['interet'], age: 12, numero: 'numero', pays: 'pays', photo: ['photo'], etablissement: "", 
  profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', email: "", online: true, token: ''); 

  Utilisateurs utilisateur = Utilisateurs(nom: 'nom', idutilisateurs: 'idutilisateurs', 
  interet: ['interet'], age: 12, numero: 'numero', pays: 'pays', photo: ['photo'], 
  profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', online: true, email: "", etablissement: "", token: '',);

  DatabaseConnection connection = DatabaseConnection();
  UtilisateurController controller = UtilisateurController();
  double progression=0;
  Map gains = {};
  int booster = 0, superLike=0; 
  bool isbooster=false;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size =  MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               SafeArea (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(getTranslated(context,'profil'),style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, settingsRoute);
                      },
                      child: const Icon(Icons.settings)
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, editprofilRoute, arguments: utilisateursOnline);
                },
                child: Center(
                  child: imagePath(),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,), 
              Center(child: Text("${utilisateur.nom.capitalize()}, ${utilisateur.age}", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,), 
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                   gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                      ],
                    ),
                  ),
                  child: TweenAnimationBuilder(
                    duration: const Duration(seconds: 3),
                    tween: Tween(begin: 0.0, end: progression),
                    builder: (context, value, child) {
                    int percentage = (double.parse(value.toString()) *100).ceil();
                      return Text("${getTranslated(context,'profil_complete')} $percentage%", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.white, fontWeight: FontWeight.bold),);
                    }
                  )
                )
              ),
              SizedBox(height: size.height*0.08),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 2
                        ),
                      ] 
                    ),
                    width: size.width*0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2
                              ),
                            ] 
                          ),
                          child: SvgPicture.asset(
                            "images/star_icon.svg",                                                
                          ),
                        ),
                        SizedBox(height: size.height*0.01),
                        Text("$superLike Restant", style: const TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: size.height*0.005),
                        const Text("Obtenir plus de Super Likes", textAlign: TextAlign.center, style: TextStyle(color: Colors.blue),)
                      ],
                    ),
                  ),
                  SizedBox(width: size.width*0.1),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 2
                        ),
                      ] 
                    ),
                    width: size.width*0.4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2
                              ),
                            ] 
                          ),
                          child: SvgPicture.asset(
                            "images/thunder_icon.svg",                                                
                          ),
                        ),
                        SizedBox(height: size.height*0.01),
                        Text("$booster Restant", style: const TextStyle(fontWeight: FontWeight.bold),),
                        SizedBox(height: size.height*0.005),
                        const Text("Obtenir plus de Booster", textAlign: TextAlign.center, style: TextStyle(color: Colors.purple),)
                      ],
                    ),
                  )
                ],
              )
             ],
          ),
        ),
      ),
    );
  }


    Widget imagePath(){
    
      const size = 200.0;
    if(_image == null){
      return TweenAnimationBuilder(
        duration: const Duration(seconds: 3),
        tween: Tween(begin: progression, end: progression),
        builder: (context, value, child) {
          return SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                ShaderMask(
                  shaderCallback: (rect){
                    return SweepGradient(
                      startAngle: 0.0,
                      endAngle: TWO_PI,
                      stops: [value as double, value],
                      center: Alignment.center,
                      colors: [Theme.of(context).primaryColor, Colors.grey.withOpacity(0.2)]
                    ).createShader(rect);
                  },
                  child: Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white
                    ),
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(3),
                        width: size-20,
                        height: size-20,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: FileImage(File(utilisateur.photo[0])),
                        )
                      ),
                      isbooster ? Positioned(
                        bottom: -1,
                        right: -1,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2
                              ),
                            ] 
                          ),
                          child: SvgPicture.asset(
                            "images/thunder_icon.svg", 
                            height: 40,
                          ),
                        ),
                      ) : const Text("")
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }else{
      return Container(
        
      );
    }
  }

  void getCurrentUser() async {
    
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      booster = _prefs.getInt("booster")!;
      superLike = _prefs.getInt("superLike")!;
      isbooster = _prefs.getBool('isBooster') ?? false;
    });

      setState(() {
        progression = (_prefs.getInt("progression") as int )/100;
      });

    await Utilisateurs.getCurrentUser().then((value){
      setState(() {
        utilisateur = value;
        
      });
    });

    await controller.getUserById2(utilisateur.idutilisateurs).then((value){
      setState(() {
        utilisateursOnline = value;
      });
    });

  }

}
