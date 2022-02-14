import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';

import '../localization/language_constants.dart';

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
                SizedBox(height: MediaQuery.of(context).size.height*0.09),
                Text(getTranslated(context,'mon_sex'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.05)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.09),
      
                InkWell(
                  onTap: (){
                      select(getTranslated(context,'homme'));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: sex.contains(getTranslated(context,'homme')) ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: sex.contains(getTranslated(context,'homme')) ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context,'homme'), style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color:sex.contains(getTranslated(context,'homme')) ? Colors.white : Colors.black)),
                        Icon(Icons.check, color: sex.contains(getTranslated(context,'homme')) ? Colors.white : Colors.black)
                      ],
                    ),
                  ),
                ),
      
                SizedBox(height: MediaQuery.of(context).size.height*0.04),
                InkWell(
                  onTap: (){
                      select(getTranslated(context,'femme'));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
                    decoration: BoxDecoration(
                      color: sex.contains(getTranslated(context,'femme')) ? Theme.of(context).primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: sex.contains(getTranslated(context,'femme')) ? null : Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context,'femme'), style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, color:sex.contains(getTranslated(context,'femme')) ? Colors.white : Colors.black)),
                        Icon(Icons.check, color: sex.contains(getTranslated(context,'femme')) ? Colors.white : Colors.black)
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
                          child: Text(getTranslated(context,'btn_continue'),
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
    if(sex.contains(getTranslated(context,'femme')) || sex.contains(getTranslated(context,'homme')) ){
        
      if (kDebugMode) {
        print(" mon sexe $sex");
      }
      Navigator.pushNamed(context, inscriptionRoute, arguments: widget.utilisateurs); 
    
    }else{

      erreurSex();
    }

  }

    Future<void> erreurSex(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'choisir_sexe')),
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



