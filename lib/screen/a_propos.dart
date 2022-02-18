import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/controllers/notification_controller.dart';
import 'package:feeling/localization/language_constants.dart';
import 'package:flutter/material.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AProposScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const AProposScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _AProposScreenState createState() => _AProposScreenState();
}

class _AProposScreenState extends State<AProposScreen> {  

  TextEditingController proposcontroller = TextEditingController();
  TextEditingController codecontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final firebase  = FirebaseFirestore.instance;
  bool loading = false;
  UtilisateurController controller = UtilisateurController();
  NotificationController notificationController = NotificationController();
  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size  = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Form(
              key: _formKey,
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
                        child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: size.width*0.06),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.04),
                  Text(getTranslated(context,'a_propos'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Text(getTranslated(context,'description'), style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.width*0.04)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  TextFormField(
                    minLines: 5,
                    maxLines: 10,
                    controller: proposcontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context,'exemple_description'),
                      // prefixIcon: Icon(Icons.work, color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return getTranslated(context,'entrer_description');
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  InkWell(
                    onTap: (){
                      codeParrainage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(getTranslated(context,'parrainage'), textAlign: TextAlign.right, style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: size.width*0.05),),
                      ],
                    ),
                  ), 
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  InkWell(
                    child: 
                    loading ?
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor ,
                        child: MaterialButton(
                          minWidth: size.width,
                          onPressed: () {  
                            propos();
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
                    ) :
                    Material(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).primaryColor ,
                        child: MaterialButton(
                          minWidth: size.width,
                          onPressed: () {  
                            propos();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(getTranslated(context,'btn_continue'),
                              style: TextStyle(color: Colors.white, fontSize: size.width*0.05, fontWeight: FontWeight.bold),
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
      ),
    );
  }

  void propos() async {
    
    if(_formKey.currentState!.validate()){

      setState(() {
        loading = true;
      });
        
      widget.utilisateurs.propos = proposcontroller.text;

      if(await tryConnection() == true){
        await controller.addUsers(widget.utilisateurs).then((value) async {
          if(value != "error"){
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.setString("idusers", value);
            widget.utilisateurs.idutilisateurs = value;
            widget.utilisateurs.token = await notificationController.getToken() as String;
            await DatabaseConnection().ajouterInteret(widget.utilisateurs.interet);
            await DatabaseConnection().ajouterUtilisateurs(widget.utilisateurs);

            setState(() {
              loading = false;
            });
            Navigator.pushReplacementNamed(context, tabRoute);

          }
        });
      }else{
        setState(() {
          loading = false;
        });
        connection();
      }

    }
  }

  Future<void> connection(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'erreur_internet')),
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

  Future<void> codeParrainage(){
      return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'parrainage')),
            content: TextFormField(
              keyboardType: TextInputType.number,
              controller: codecontroller,
              decoration: InputDecoration(
                hintText: getTranslated(context,'parrainage'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(20),
                filled: true,
                // fillColor: Colors.grey.withOpacity(0.3),
              ),
              validator: (value){
                if(value!.isEmpty){
                  return getTranslated(context,'parrainage');
                }else{
                  return null;
                }
              },
            ),
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
