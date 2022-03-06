import 'package:feeling/controllers/google_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controllers/facebook._login_controller.dart';

class FacebookLoginPage extends StatefulWidget {
  const FacebookLoginPage({ Key? key }) : super(key: key);

  @override
  State<FacebookLoginPage> createState() => _FacebookLoginPageState();
}

class _FacebookLoginPageState extends State<FacebookLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social SignIn"),
      ),
      body: loginUI(),
    );
  }

  loginUI(){
    return Consumer<FacebookSignInController>(
      builder: (context, model, child){
        if(model.userData != null){
          return Center(child: loggedInUI(model));
        }else{
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(FacebookSignInController model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // CircleAvatar(
        //   backgroundImage: Image.network(model.userData!.photoUrl ?? '').image,
        //   radius: 50,
        // ),
        Text(model.userData!["name"] ?? ''),
        Text(model.userData!["name"]),
        ActionChip(
          avatar: const Icon(Icons.logout),
          label: const Text("Logout"),
          onPressed: (){
            Provider.of<FacebookSignInController>(context, listen: false).logOut();
          }
        )
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        children: [
          // InkWell( 
          //   // onTap: (){
          //   //   Provider.of<GoogleSignInController>(context, listen: false).login();
          //   // },
          //   child: const Text("Connexion avec google")
          // ),
          InkWell(
            onTap: (){
              Provider.of<FacebookSignInController>(context, listen: false).login();
            },
            child: const Text("Connexion avec Facebook")
          )
        ],
      ),
    );
  }
}