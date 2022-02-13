import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';


class PhoneIdentificationScreen extends StatefulWidget {
  const PhoneIdentificationScreen({Key? key}) : super(key: key);


  @override
  _PhoneIdentificationScreenState createState() => _PhoneIdentificationScreenState();
}

class _PhoneIdentificationScreenState extends State<PhoneIdentificationScreen> {

  Utilisateurs  utilisateurs = Utilisateurs(nom: 'nom', idutilisateurs: 'idutilisateurs', interet: ['interet'], age: 20, 
  numero: '690', pays: 'pays', photo: ['photo'], profession: 'profession', sexe: 'sexe', ville: 'ville', propos: 'propos', 
  online: false, email: "", etablissement: "", entreprise: "", token: '',);
  final _formKey = GlobalKey<FormState>();

  final phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height*0.08),
                  Text("Mon numéro", textAlign: TextAlign.left, style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.07)
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Text("Veuillez entrer votre numéro de téléphone valide. Nous vous enverrons un code à 6 chiffres pour vérifier votre compte ", 
                  textAlign: TextAlign.left, style: TextStyle( fontSize: MediaQuery.of(context).size.width*0.04)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.04),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: phonecontroller,
                    decoration: InputDecoration(
                      hintText: "Entrer votre numéro de téléphone",
                      prefixIcon: Icon(Icons.phone, color: Theme.of(context).primaryColor,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value){
                      if(value!.isNotEmpty){
                        RegExp regex = RegExp(r"^6[957][0-9]{7}$");
                        if(!regex.hasMatch(value)){
                          return "votre numéro est invalide";
                        }else{
                          return null;
                        }
                      }else{
                        return "Veuillez entrer un numéro";
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.05),
                  Text("NB: Nous sommes disponible uniquement au cameroun", 
                  textAlign: TextAlign.left, style: TextStyle( fontSize: MediaQuery.of(context).size.width*0.04, fontWeight: FontWeight.bold)),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () { identification(); },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Continuer",
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Center(
                    child: InkWell(
                      child: Text("Ajouter mon pays dans feeling", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),)
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

  identification(){
      
    if(_formKey.currentState!.validate()){
      utilisateurs.numero = phonecontroller.text;
      Navigator.pushNamed(context, verificationRoute, arguments: utilisateurs);
    }
  }
}

