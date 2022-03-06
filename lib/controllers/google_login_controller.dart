import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInController {

  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAcount;
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;

  login() async{

    googleAcount = await _googleSignIn.signIn();

    if(googleAcount != null){
      
      final GoogleSignInAuthentication googleSignInAuthentication = await googleAcount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        
        user = userCredential.user;

        return user;

      } on FirebaseAuthException catch (e) {

        print(" message ${e.message} code ${e.code}");
        
      } catch (e) {
        // handle the error here
      }

    }

    
  }

  logOut() async{
    this.googleAcount = await _googleSignIn.signOut();
  }

}