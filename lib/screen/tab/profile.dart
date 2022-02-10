import 'dart:io';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';

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
  profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', email: "", entreprise: "", online: true); 

  Utilisateurs utilisateur = Utilisateurs(nom: 'nom', idutilisateurs: 'idutilisateurs', 
  interet: ['interet'], age: 12, numero: 'numero', pays: 'pays', photo: ['photo'], 
  profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', online: true, email: "", etablissement: "", entreprise: "",);

  DatabaseConnection connection = DatabaseConnection();
  UtilisateurController controller = UtilisateurController();

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    const Text("Profil",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
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
                  child: Text("Complété mon profil (10%)", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.white, fontWeight: FontWeight.bold),)
                )
              ),
              
              
             ],
          ),
        ),
      ),
    );
  }

    Widget imagePath(){
    
      const size = 200.0;
    if(_image == null){
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
                  stops: const [0.1, 0.1],
                  center: Alignment.center,
                  colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.2)]
                ).createShader(rect);
              },
              child: Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink
                ),
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(3),
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
            )
          ],
        ),
      );
    }else{
      return Container(
        
      );
    }
  }

  void getCurrentUser() async {
    await Utilisateurs.getCurrentUser().then((value){
      setState(() {
        utilisateur = value;
        
      });
    });

    print("id ${utilisateur.idutilisateurs}");

    await controller.getUserById2(utilisateur.idutilisateurs).then((value){
      setState(() {
        print("information $value");
        utilisateursOnline = value;
      });
    });

  }

}
