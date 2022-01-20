import 'package:flutter/material.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);


  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
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
                                child: Image.asset("images/userImage4.jpeg", fit: BoxFit.cover)
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
                                child: Image.asset("images/userImage5.jpeg", fit: BoxFit.cover)
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
                Text("C'est un match, Kemane", style: TextStyle(fontSize: size.width*0.08, fontWeight: FontWeight.bold),),
                SizedBox(height: size.height*0.02),
                Text("Vous avez la musique centre d'interêt commun avec carlos", textAlign: TextAlign.center, style: TextStyle(fontSize: size.width*0.04, ),),
                SizedBox(height: size.height*0.05),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {  },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Commencer la conversation",
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
}

