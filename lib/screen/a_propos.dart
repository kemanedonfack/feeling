import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:location/location.dart';

class AProposScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const AProposScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _AProposScreenState createState() => _AProposScreenState();
}

class _AProposScreenState extends State<AProposScreen> {  

  
  TextEditingController proposcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final firebase  = FirebaseFirestore.instance;
  bool loading = false;
  UtilisateurController controller = UtilisateurController();
  late LocationData _locationData;

  @override
  void initState() {
    localisation();
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
                  Text("A Propos de moi", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Text("Donne une brèvre description de toi en quelques mots.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.width*0.04)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                    TextFormField(
                      minLines: 5,
                      maxLines: 10,
                      controller: proposcontroller,
                      decoration: InputDecoration(
                      hintText: "Je suis une étudiante en biochimie à l'Université de douala à la recherche d'une relation sérieuse...",
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
                          return "Entre une brèvre description de toi";
                        }else{
                          return null;
                        }
                      },
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
                            child: Text("Continue",
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
      // bottomNavigationBar: Padding(
      //   padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
      //   child: InkWell(
          
      //     child: 
      //     loading ?
      //     Material(
      //       borderRadius: BorderRadius.circular(10.0),
      //       color: Theme.of(context).primaryColor ,
      //         child: MaterialButton(
      //           minWidth: size.width,
      //           onPressed: () {  
      //             propos();
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: CircularProgressIndicator(color: Colors.white),
      //         ),
      //       ),
      //     ) :
      //     Material(
      //       borderRadius: BorderRadius.circular(10.0),
      //       color: Theme.of(context).primaryColor ,
      //         child: MaterialButton(
      //           minWidth: size.width,
      //           onPressed: () {  
      //             propos();
      //           },
      //           child: Padding(
      //             padding: const EdgeInsets.all(8.0),
      //             child: Text("Continue",
      //               style: TextStyle(color: Colors.white, fontSize: size.width*0.05, fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  void propos() async {
    if (kDebugMode) {
      print("Données utilisateurs ${widget.utilisateurs.interet}");
    }

    if(_formKey.currentState!.validate()){

      setState(() {
        loading = true;
      });
        
      widget.utilisateurs.propos = proposcontroller.text;

      if(await Utile.tryConnection() == true){
        await controller.addUsers(widget.utilisateurs, _locationData).then((value) async {
          if(value != "error"){
            if (kDebugMode) {
              print("id insersion $value");
            }
            widget.utilisateurs.idutilisateurs = value;
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
            title: const Text("Erreur"),
            content: const Text("Veuillez vous connectez à internet"),
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
  
  Future<void> localisation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
  }

}
