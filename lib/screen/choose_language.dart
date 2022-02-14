import 'package:feeling/models/language.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import '../localization/language_constants.dart';


class ChooseLanguageScreen extends StatefulWidget {
  const ChooseLanguageScreen({Key? key}) : super(key: key);


  @override
  _ChooseLanguageScreenState createState() => _ChooseLanguageScreenState();
}

class _ChooseLanguageScreenState extends State<ChooseLanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Text(getTranslated(context, 'choisir_langue_prefere')  , style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.06)
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.02,
              ),
              Text(getTranslated(context, 'choisir_langue'), style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04)
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: Language.languageList().length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: (){
                            changeLanguage(Language.languageList()[index]);
                          },
                          child: Row(
                            children: [
                              Container(
                                 padding: const EdgeInsets.only(left: 50),
                                height: MediaQuery.of(context).size.height*0.03,
                                child: Image.asset(Language.languageList()[index].flag, fit: BoxFit.cover)
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width*0.05,
                              ),
                              Text(Language.languageList()[index].name, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.04)
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Divider(color: Colors.grey),
                        ),
                        
                      ],
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
                  onPressed: () { Navigator.pushNamed(context, welcomeRoute); },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context, 'btn_continue'),
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ),
      
    );
  }

  void changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }
}

