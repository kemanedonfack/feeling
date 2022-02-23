import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import '../controllers/utilisateur_controller.dart';
import '../db/db.dart';

class UpdateCountryScreen extends StatefulWidget {

  final Utilisateurs utilisateurs;
  const UpdateCountryScreen(this.utilisateurs, {Key? key}) : super(key: key);  

  @override
  _UpdateCountryScreenState createState() => _UpdateCountryScreenState();
}

class _UpdateCountryScreenState extends State<UpdateCountryScreen> {
  
  final _formKey = GlobalKey<FormState>();

  UtilisateurController utilisateurController = UtilisateurController();
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Emplacement", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor)
        ),
        
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  CSCPicker(
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.DISABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 1)
                    ),

                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade300,
                      border:  Border.all(color: Colors.grey.shade300, width: 1)
                    ),

                    countrySearchPlaceholder: "Pays",
                    stateSearchPlaceholder: "region",
                    citySearchPlaceholder: "ville",

                    countryDropdownLabel: "Pays",
                    stateDropdownLabel: "region",
                    cityDropdownLabel: "ville",

                    selectedItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    dropdownHeadingStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),

                    dropdownItemStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),

                    dropdownDialogRadius: 10.0,

                    searchBarRadius: 10.0,

                    onCountryChanged: (value) {
                      setState(() {
                        country.text = value;
                      });
                    },

                    onStateChanged: (value) {
                      if(value != null){
                        setState(() {
                          state.text = value;
                        });
                      }
                    },

                    onCityChanged: (value) {
                      if(value != null){
                        setState(() {
                          city.text = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () { save(); },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Enregistrer",
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

  void save() async {
    
    if(city.text.isEmpty) {
      if (kDebugMode) {
        print("veuiller choisir un emplacement");
      } 
    }else{
      widget.utilisateurs.ville = city.text;
      widget.utilisateurs.pays = country.text;
      
      await DatabaseConnection().deleteUtilisateurs();
      await DatabaseConnection().ajouterUtilisateurs(widget.utilisateurs);

      utilisateurController.updateCountry(widget.utilisateurs);
      Navigator.pushNamedAndRemoveUntil(context, tabRoute, (route) => false);
    }

  }

}


