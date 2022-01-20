import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';

class MonSexScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const MonSexScreen(this.utilisateurs, {Key? key}) : super(key: key);  

  @override
  _MonSexScreenState createState() => _MonSexScreenState();
}

class _MonSexScreenState extends State<MonSexScreen> {

  String sex="";

 @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
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
                SizedBox(height: MediaQuery.of(context).size.height*0.09),
                Text("Je suis un(e)", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.05)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.09),
      
                InkWell(
                  onTap: (){
                      select("Homme");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: sex.contains("Homme") ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: sex.contains("Homme") ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Homme", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color:sex.contains("Homme") ? Colors.white : Colors.black)),
                        Icon(Icons.check, color: sex.contains("Homme") ? Colors.white : Colors.black)
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
                InkWell(
                  onTap: (){
                      select("Femme");
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: sex.contains("Femme") ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: sex.contains("Femme") ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Femme", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color:sex.contains("Femme") ? Colors.white : Colors.black)),
                        Icon(Icons.check, color: sex.contains("Femme") ? Colors.white : Colors.black)
                      ],
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
                InkWell(
                  child: Material(
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
                    ),
                ),
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

  void select(String sexe) {
    if(!sex.contains(sexe)){
      setState(() {
        sex=sexe;
      });
    }else{
      setState(() {
        sex=sexe;
      });
    }
  }

  void continuer(){

    widget.utilisateurs.sexe = sex;
    if(sex.contains("Femme") || sex.contains("Homme") ){
        
      if (kDebugMode) {
        print(" mon sexe $sex");
      }
      Navigator.pushNamed(context, inscriptionRoute, arguments: widget.utilisateurs); 
    
    }else{

      erreurSex();
    }

    // if(sex.contains("Femme")){
    //   widget.utilisateurs.sexe = "Femme";
    //   widget.utilisateurs.abonnement = false;
    //   Navigator.pushNamed(context, escortinscriptionRoute, arguments: widget.utilisateurs);
    // }else if(sex.contains("Homme")){
    //   widget.utilisateurs.sexe = "Homme";
    //   widget.utilisateurs.abonnement = false;
    //  Navigator.pushNamed(context, tabRoute, arguments: widget.utilisateurs); 
    // }

  }

    Future<void> erreurSex(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Choisir ton sexe"),
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


