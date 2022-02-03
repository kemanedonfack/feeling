import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/interets.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';

class InteretScreen extends StatefulWidget {
    
  final Utilisateurs utilisateurs;
  const InteretScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _InteretScreenState createState() => _InteretScreenState();
}

class _InteretScreenState extends State<InteretScreen> {

  List<String> mesinteret = [];
  List tags = ['one','two']; 

  List<Interet> listinteret = [
    Interet(nom: "Shopping", icone: Icons.shopping_bag_outlined),
    Interet(nom: "Photographie", icone: Icons.camera_alt_outlined),
    Interet(nom: "Basket", icone: Icons.sports_basketball_outlined),
    Interet(nom: "Course", icone: Icons.directions_run),
    Interet(nom: "Music", icone: Icons.music_note),
    Interet(nom: "Cinéma", icone: Icons.local_movies_rounded),
    Interet(nom: "Hanball", icone: Icons.sports_handball),
    Interet(nom: "Jeux vidéo", icone: Icons.sports_esports_rounded),
    Interet(nom: "Art", icone: Icons.format_paint),
    Interet(nom: "Cuisine", icone: Icons.food_bank),
    Interet(nom: "Football", icone: Icons.sports_soccer),
    Interet(nom: "Lecture", icone: Icons.chrome_reader_mode),
    Interet(nom: "Facebook", icone: Icons.facebook),
    Interet(nom: "Voyage", icone: Icons.travel_explore),
    Interet(nom: "Business", icone: Icons.business),
    Interet(nom: "Agriculture", icone: Icons.agriculture),
    Interet(nom: "bénévolat", icone: Icons.volunteer_activism),
    Interet(nom: "Tenis", icone: Icons.sports_tennis),
    Interet(nom: "Lutte", icone: Icons.sports_kabaddi),
    Interet(nom: "Boxes", icone: Icons.sports_mma),
    Interet(nom: "volleyball", icone: Icons.sports_volleyball),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Text("Centre d'intérêts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.06)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Text("sélectionnez quelques-uns de vos centres d'intérêt et faites savoir à tout le monde ce qui vous passionne.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.width*0.04)
                ), 
                SizedBox(height: MediaQuery.of(context).size.height*0.03),
                
                // Wrap(
                //   spacing: 10,
                //   runSpacing: 10,
                //   children: [
                //     for(int i=0; i<listinteret.length; i++)
                //       InkWell(
                //         onTap: (){
                //           ajouter(listinteret[i].nom);
                //         },
                //         child: Container(
                //           padding: const EdgeInsets.all(4),
                //           decoration: BoxDecoration(
                //             color: mesinteret.contains(listinteret[i].nom) ? Theme.of(context).primaryColor : Colors.white,
                //             borderRadius: BorderRadius.circular(10),
                //             border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                //           ),
                //           child: Wrap(
                //             children: [
                //               Icon(listinteret[i].icone, color: mesinteret.contains(listinteret[i].nom) ? Colors.white : Theme.of(context).primaryColor),
                //               SizedBox(width: MediaQuery.of(context).size.width*0.025),
                //               Text(listinteret[i].nom, maxLines: 1,  overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: mesinteret.contains(listinteret[i].nom) ? Colors.white : Colors.black, fontSize: MediaQuery.of(context).size.width*0.04)),
                //             ],
                //           ),
                //         ),
                //       )
                //   ],
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listinteret.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisExtent: MediaQuery.of(context).size.height * 0.06,
                          crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          ajouter(listinteret[index].nom);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: mesinteret.contains(listinteret[index].nom) ? Theme.of(context).primaryColor : Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                          ),
                          child: Row(
                            children: [
                              Icon(listinteret[index].icone, color: mesinteret.contains(listinteret[index].nom) ? Colors.white : Theme.of(context).primaryColor),
                              SizedBox(width: MediaQuery.of(context).size.width*0.025),
                              Flexible(child: Text(listinteret[index].nom, maxLines: 1,  overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.w600, color: mesinteret.contains(listinteret[index].nom) ? Colors.white : Colors.black, fontSize: MediaQuery.of(context).size.width*0.04))),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.03),
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {  
                      continuer();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Continue",
                        style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      //   child: InkWell(
          
      //     child: Material(
      //       borderRadius: BorderRadius.circular(10.0),
      //       color: Theme.of(context).primaryColor ,
      //         child: MaterialButton(
      //           minWidth: MediaQuery.of(context).size.width,
      //           onPressed: () {  
      //             continuer();
      //            },
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text("Continue",
      //               style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
      //             ),
      //           ),
      //         ),
      //       ),
      //   ),
      // ),
    );
  }

  void ajouter(String nom) {
    if(!mesinteret.contains(nom)){
      setState(() {
        mesinteret.add(nom);
      });
    }else{
      setState(() {
        mesinteret.removeWhere((val) => val == nom);
      });
    }
  }

  void continuer(){
    for(int i=0; i<mesinteret.length; i++){
      if (kDebugMode) {
        print(mesinteret[i]);
      }
    }

    if(mesinteret.isNotEmpty){
      widget.utilisateurs.interet = mesinteret;
      Navigator.pushNamed(context, aproposRoute, arguments: widget.utilisateurs); 
    }else{
      erreurInteret();
    }
  }

    Future<void> erreurInteret(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Veuillez choisir au moins un centre intérêt"),
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
