import 'dart:io';

import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  final Utilisateurs utilisateurs;
  // final Utilisateurs utilisateurslocal;
  const MatchScreen(this.utilisateurs, {Key? key}) : super(key: key);
  // const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {

  DatabaseConnection connection = DatabaseConnection();
  Utilisateurs utilisateurslocal = Utilisateurs(nom: 'nom', idutilisateurs: 'idutilisateurs', interet: ["interet"], age: 20, numero: 'numero',
   pays: 'pays', photo: ["images/userImage5.jpeg"], profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', online: false, 
   email: "", etablissement: "", token: '',);

  @override
  void initState() {
    getUtilisateurs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: size.height*0.5,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Stack(
                          children: [
                            Container(
                              width: size.width*0.35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(widget.utilisateurs.photo[0], fit: BoxFit.cover)
                              ),
                              transform: Matrix4.rotationZ(0.3),
                            ),
                            Positioned(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(Icons.favorite, color: Theme.of(context).primaryColor,)
                              )
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Stack(
                          children: [
                            Container(
                              width: size.width*0.35,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(File(utilisateurslocal.photo[0]),  fit: BoxFit.cover)
                              ),
                              transform: Matrix4.rotationZ(-0.2),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 60,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(Icons.favorite, color: Theme.of(context).primaryColor,)
                              )
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.05),
                Text("C'est un match, ${utilisateurslocal.nom}", style: TextStyle(fontSize: size.width*0.08, fontWeight: FontWeight.bold),),
                SizedBox(height: size.height*0.02),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Envoyé une demande",
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height*0.03),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () { Navigator.of(context).pop(); },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Retour",
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
    );
  }

  void getUtilisateurs() async {

    await connection.getUtilisateurs().then((value){
      setState(() {
        utilisateurslocal = value[0];
      });
    });
  }

}

