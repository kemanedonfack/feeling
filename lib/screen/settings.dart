import 'package:flutter/material.dart';

import '../localization/language_constants.dart';
import '../routes/route_name.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: InkWell(
          onTap: (){
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.close)
        ),
        title: Text(getTranslated(context,'parametre'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              ListTile(
                onTap: (){
                  Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.translate),
                title: Text(getTranslated(context,'change_langue')),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.people),
                title: Text(getTranslated(context,'inviter_titre')),
                subtitle:  Text(getTranslated(context,'inviter_description')),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.insert_drive_file),
                title: Text(getTranslated(context,'politique_confidentialite')),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.help_outline),
                title: Text(getTranslated(context,'aide')),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.warning),
                title: Text(getTranslated(context,'signaler')),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.people),
                title: Text(getTranslated(context,'nous_contacter')),
              ),
            ],
          ),
        )
      ),
    );
  }
}