import 'package:country_state_city_pro/country_state_city_pro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import '../localization/language_constants.dart';

class InscriptionScreen extends StatefulWidget {

  final Utilisateurs utilisateurs;
  const InscriptionScreen(this.utilisateurs, {Key? key}) : super(key: key);  

  @override
  _InscriptionScreenState createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends State<InscriptionScreen> {

  
  final _formKey = GlobalKey<FormState>();

  String sex="";

  TextEditingController nomcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController villecontroller = TextEditingController();
  TextEditingController payscontroller = TextEditingController();
  TextEditingController professioncontroller = TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  
  List<String> villes = ["Douala", "Yaoundé", "Bamenda", "Buéa", "Ngaoundére", "Garoua", "Maroua"];
  String? ville="Douala";
  String pays="Cameroun";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                        child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.06),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(getTranslated(context,'profil'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.065)
                    ),
                  ),              
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  TextFormField(
                    controller: nomcontroller,
                    decoration: InputDecoration(
                    hintText: getTranslated(context,'nom_utilisateur'),
                    prefixIcon: Icon(Icons.person, color: Theme.of(context).primaryColor,),
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
                        return getTranslated(context,'entrer_nom');
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: agecontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context,'age'),
                      prefixIcon: Icon(Icons.date_range, color:  Theme.of(context).primaryColor),
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
                          return getTranslated(context,'entrer_age');
                        }else{
                          return null;
                        }
                      },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  TextFormField(
                    controller: professioncontroller,
                    decoration: InputDecoration(
                    hintText: getTranslated(context,'entrer_profession'),
                    prefixIcon: Icon(Icons.work, color: Theme.of(context).primaryColor,),
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
                        return  getTranslated(context,'entrer_profession');
                      }else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  TextFormField(
                    // controller: professioncontroller,
                    decoration: InputDecoration(
                      hintText: pays,
                      enabled: false,
                      prefixIcon: Icon(Icons.location_city, color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: CountryStateCityPicker(
                      country: country,
                      state: state,
                      city: city,    
                      textFieldInputBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
            
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () { inscription(); },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text( getTranslated(context,'btn_inscription'),
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
      ),
     
    );
  }

  inscription(){
    
    if(_formKey.currentState!.validate()){

      widget.utilisateurs.age = int.parse(agecontroller.text);
      widget.utilisateurs.nom = nomcontroller.text;
      widget.utilisateurs.pays = payscontroller.text;
      widget.utilisateurs.ville = city.text;
      widget.utilisateurs.profession = professioncontroller.text;
      widget.utilisateurs.pays = pays;

      Navigator.pushNamed(context, uploadimageRoute, arguments: widget.utilisateurs);
    }else{

      if (kDebugMode) {
        print("Veuillez remplir les champs");
      }
    }

  }

}


