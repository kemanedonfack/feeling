import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';

class ModifierProfilScreen extends StatefulWidget {

  @override
  _ModifierProfilScreenState createState() => _ModifierProfilScreenState();
}

class _ModifierProfilScreenState extends State<ModifierProfilScreen> {

  @override
  Widget build(BuildContext context) {
    
  var size =MediaQuery.of(context).size;
 
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Modifier mon profil", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor)
        )
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: size.height*0.2,
                      width: size.width*0.3,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("images/girls/img_3.jpeg"),
                          fit: BoxFit.cover
                        ),
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.close, size: 18, color: Theme.of(context).primaryColor),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: size.height*0.2,
                      width: size.width*0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.add_a_photo, size: 18, color: Theme.of(context).primaryColor),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 5),
                      height: size.height*0.2,
                      width: size.width*0.3,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            child: Icon(Icons.add_a_photo, size: 18, color: Theme.of(context).primaryColor),
                            backgroundColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {   },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ajouter Photo",
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
                Text("Nom", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, modifierinformationRoute);
                  },
                  child: Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                      child: Text("Kemane Donfack"),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("Age", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("20"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("Pays", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("Cameroun"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("Ville", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("Douala"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("Centre d'intérêt", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("Football, Jeux vidéo, Natation"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("Profession", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    child: Text("Etudiant"),
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
