import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookSignInController {

  Map? userData;
  User? user;
  FirebaseAuth auth = FirebaseAuth.instance;

  login() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"]
    );

    if(result.status == LoginStatus.success){
      
      final AuthCredential facebookCredential = FacebookAuthProvider.credential(result.accessToken!.token);
             
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email, name, picture",
      );
      userData = requestData;

      try {
        
        final userCredential = await auth.signInWithCredential(facebookCredential);
        // final  userCredential = await auth.signInWithCredential(facebookCredential);
        
        user = userCredential.user;
        print("utilisateur $user");

        return user;

      } on FirebaseAuthException catch (e) {
        print(" message ${e.message} code ${e.code}");
        
      } catch (e) {
        // handle the error here
      }
    }
    // return userData;
  }

  logOut() async {
    await FacebookAuth.i.logOut();
    userData = null;
  }

}
