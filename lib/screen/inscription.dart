import 'package:csc_picker/csc_picker.dart';
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

  String sex = "";

  TextEditingController nomcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController villecontroller = TextEditingController();
  TextEditingController professioncontroller = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();

  @override
  void initState() {
    if (widget.utilisateurs.nom != '') {
      nomcontroller.text = widget.utilisateurs.nom;
    }
    super.initState();
  }

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
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Colors.grey,
                            width: 1,
                            style: BorderStyle.solid),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 15),
                        child: Icon(Icons.arrow_back_ios,
                            color: Theme.of(context).primaryColor,
                            size: MediaQuery.of(context).size.width * 0.06),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(getTranslated(context, 'profil'),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.065)),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  TextFormField(
                    controller: nomcontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'nom_utilisateur'),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, 'entrer_nom');
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: agecontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'age'),
                      prefixIcon: Icon(Icons.date_range,
                          color: Theme.of(context).primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, 'entrer_age');
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  TextFormField(
                    controller: professioncontroller,
                    decoration: InputDecoration(
                      hintText: getTranslated(context, 'entrer_profession'),
                      prefixIcon: Icon(
                        Icons.work,
                        color: Theme.of(context).primaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.3),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return getTranslated(context, 'entrer_profession');
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  CSCPicker(
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.DISABLE,

                    ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                    dropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:
                            Border.all(color: Colors.grey.shade300, width: 1)),

                    countrySearchPlaceholder: "Pays",
                    stateSearchPlaceholder: "region",
                    citySearchPlaceholder: "ville",

                    countryDropdownLabel: "Pays",
                    stateDropdownLabel: "region",
                    cityDropdownLabel: "ville",

                    defaultCountry: DefaultCountry.Cameroon,

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
                      if (value != null) {
                        setState(() {
                          state.text = value;
                        });
                      }
                    },

                    onCityChanged: (value) {
                      if (value != null) {
                        setState(() {
                          city.text = value;
                        });
                      }
                    },
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        inscription();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          getTranslated(context, 'btn_inscription'),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.05,
                              fontWeight: FontWeight.bold),
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

  inscription() {
    if (_formKey.currentState!.validate()) {
      if (city.text.isNotEmpty) {
        widget.utilisateurs.age = int.parse(agecontroller.text);
        widget.utilisateurs.nom = nomcontroller.text;
        widget.utilisateurs.pays = country.text;
        widget.utilisateurs.ville = city.text;
        widget.utilisateurs.profession = professioncontroller.text;

        Navigator.pushNamed(context, uploadimageRoute,
            arguments: widget.utilisateurs);
      } else {
        erreurInscription();
      }
    } else {
      if (kDebugMode) {
        print("Veuillez remplir les champs");
      }
    }
  }

  Future<void> erreurInscription() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext) {
          return AlertDialog(
            title: Text(getTranslated(context, "title_erreur")),
            content: Text("Veuillez entrer votre ville"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        });
  }
}
