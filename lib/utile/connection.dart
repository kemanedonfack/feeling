import 'dart:io';

class Connection{
 
  static Future<bool> tryConnection() async {
    try {
      final response = await InternetAddress.lookup('console.firebase.google.com');
          
        print("reponse ${response}");
      return true;
    } on SocketException catch (e) {   
      return false;
    }
  }

}



