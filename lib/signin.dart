import 'package:feeling/controllers/google_login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social SignIn"),
      ),
      body: loginUI(),
    );
  }

  loginUI(){
    return Consumer<GoogleSignInController>(
      builder: (context, model, child){
        if(model.googleAcount != null){
          return Center(child: loggedInUI(model));
        }else{
          return loginControls(context);
        }
      },
    );
  }

  loggedInUI(GoogleSignInController model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: Image.network(model.googleAcount!.photoUrl ?? '').image,
          radius: 50,
        ),
        Text(model.googleAcount!.displayName ?? ''),
        Text(model.googleAcount!.email),
        ActionChip(
          avatar: Icon(Icons.logout),
          label: Text("Logout"),
          onPressed: (){
            Provider.of<GoogleSignInController>(context, listen: false).logOut();
          }
        )
      ],
    );
  }

  loginControls(BuildContext context) {
    return Center(
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Provider.of<GoogleSignInController>(context, listen: false).login();
            },
            child: Text("Connexion avec google")
          ),
          Text("Connexion avec Facebook")
        ],
      ),
    );
  }
}
