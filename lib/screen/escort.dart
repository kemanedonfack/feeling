import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';

class EscortInscriptionScreen extends StatefulWidget {

  final Utilisateurs utilisateurs;
  EscortInscriptionScreen(this.utilisateurs);  

  @override
  _EscortInscriptionScreenState createState() => _EscortInscriptionScreenState();
}

class _EscortInscriptionScreenState extends State<EscortInscriptionScreen> {

  List<String> disponibilite=["deplace"];
  List<String> services = ["vaginal"];
  String corpulence="moyenne";

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                Center(
                  child: Text("Infos Escort Girl", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.065)
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.06),
                Text("Je", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                const SizedBox(height: 10,),
                Row( 
                  children: [
                    InkWell(
                      onTap: (){
                        selectDispo("deplace");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: size.width*0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: disponibilite.contains("deplace") ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid)
                        ),
                        child: Center(child: Text("me déplace", style: TextStyle(color: disponibilite.contains("deplace") ? Colors.white : Theme.of(context).primaryColor))),
                      ),
                    ),
                      SizedBox(width: size.width*0.01),
                      InkWell(
                        onTap: (){
                          selectDispo("recois");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: size.width*0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: disponibilite.contains("recois") ? Theme.of(context).primaryColor : Colors.white,
                            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                          ),
                          child: Center(
                            child: Text("reçois", style: TextStyle(color: disponibilite.contains("recois") ? Colors.white : Theme.of(context).primaryColor))
                          ),
                        ),
                      )
                  ],
                ),

                SizedBox(height: MediaQuery.of(context).size.height*0.05),

                Text("Mes services", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                const SizedBox(height: 10,),
                Row( 
                  children: [
                    InkWell(
                      onTap: (){
                        ajouterService("pipe");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: services.contains("pipe") ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid)
                        ),
                        child: Center(child: Text("Pipe", style: TextStyle(color: services.contains("pipe") ? Colors.white : Theme.of(context).primaryColor),)),
                      ),
                    ),
                      SizedBox(width: size.width*0.01),
                      InkWell(
                      onTap: (){
                        ajouterService("vaginal");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: services.contains("vaginal") ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid)
                        ),
                        child: Center(child: Text("Vaginal", style: TextStyle(color: services.contains("vaginal") ? Colors.white : Theme.of(context).primaryColor),)),
                      ),
                    ),
                      SizedBox(width: size.width*0.01),
                      InkWell(
                      onTap: (){
                        ajouterService("anal");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: services.contains("anal") ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid)
                        ),
                        child: Center(child: Text("Anal", style: TextStyle(color: services.contains("anal") ? Colors.white : Theme.of(context).primaryColor),)),
                        ),
                    ),
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.05),
                Text("Corpulence", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                const SizedBox(height: 10,),
                Row( 
                  children: [
                    InkWell(
                      onTap: (){
                        selectCorpulence("ronde");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        width: size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: corpulence.contains("ronde") ? Theme.of(context).primaryColor : Colors.white,
                          border: Border.all(color: Colors.grey.shade300, width: 2, style: BorderStyle.solid)
                        ),
                        child: Center(child: Text("Ronde", style: TextStyle(color: corpulence.contains("ronde") ? Colors.white : Theme.of(context).primaryColor),)),
                        ),
                    ),
                      SizedBox(width: size.width*0.01),
                      InkWell(
                      onTap: (){
                        selectCorpulence("moyenne");
                      },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: size.width*0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: corpulence.contains("moyenne") ? Theme.of(context).primaryColor : Colors.white,
                            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                          ),
                        child: Center(child: Text("Moyenne", style: TextStyle(color: corpulence.contains("moyenne") ? Colors.white : Theme.of(context).primaryColor),)),
                        ),
                      ),
                      SizedBox(width: size.width*0.01),
                      InkWell(
                        onTap: (){
                        selectCorpulence("manequaine");
                      },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: size.width*0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: corpulence.contains("manequaine") ? Theme.of(context).primaryColor : Colors.white,
                            border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                          ),
                        child: Center(child: Text("Manéquainne", style: TextStyle(color: corpulence.contains("manequaine") ? Colors.white : Theme.of(context).primaryColor),)),
                        ),
                      )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
  
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () { continuer(); },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Suivant",
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

   void selectDispo(String index) {
    if(!disponibilite.contains(index)){
      setState(() {
        disponibilite.add(index);
      });
    }else{
      setState(() {
        disponibilite.removeWhere((val) => val == index);
      });
    }
  }

  void selectCorpulence(String valeur) {
    if(!corpulence.contains(valeur)){
      setState(() {
        corpulence=valeur;
      });
    }else{
      setState(() {
        corpulence=valeur;
      });
    }
  }

   void ajouterService(String index) {
    if(!services.contains(index)){
      setState(() {
        services.add(index);
      });
    }else{
      setState(() {
        services.removeWhere((val) => val == index);
      });
    }
  }

  void continuer(){

    // widget.utilisateurs.services = services;
    // widget.utilisateurs.corpulence = corpulence;
    // widget.utilisateurs.disponibilite = disponibilite;

    print("disponibilité $disponibilite mes services $services ma corpulence $corpulence");
    
    Navigator.pushNamed(context, photoescortRoute, arguments: widget.utilisateurs);
  }

}
