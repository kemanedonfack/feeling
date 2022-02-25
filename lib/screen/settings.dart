import 'package:flutter/material.dart';

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
        title: Text("Paramètres ", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),),
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
                title: const Text("Changer de langue"),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.people),
                title: const Text("Inviter un(e) ami(e)"),
                subtitle: const Text("Inviter un ami et gagnez un booster"),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.insert_drive_file),
                title: const Text("Politique de confidentialité"),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.help_outline),
                title: const Text("Aide et assistance"),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.warning),
                title: const Text("Signalez un probleme"),
              ),
              ListTile(
                onTap: (){
                  // Navigator.pushNamed(context, updateLanguageRoute);
                },
                leading: const Icon(Icons.people),
                title: const Text("Nous contacter"),
              ),
            ],
          ),
        )
      ),
    );
  }
}