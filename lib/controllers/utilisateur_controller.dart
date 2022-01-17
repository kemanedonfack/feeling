import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/models/utilisateurs.dart';


class UtilisateurController{
  
  CollectionReference users  = FirebaseFirestore.instance.collection('users');

    Future<List<Utilisateurs>> getAllUsers() async {

      List<Utilisateurs> listutilisateurs = [];
      print("dans le controller");
     
      await users.get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          print(element.data());
            listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
         }
      });

      return listutilisateurs;
    }

    Future<String> addUsers(Utilisateurs utilisateurs) async {

      try{
        print("pret");

          await users.doc().set({
            "nom" : utilisateurs.nom,
            "age" : utilisateurs.age,
            "ville" : utilisateurs.ville,
            "pays" : utilisateurs.pays,
            "profession" : utilisateurs.profession,
            "sexe" : utilisateurs.sexe,
            "numero" : utilisateurs.numero,
            "photo" : utilisateurs.photo,
            "interet" : utilisateurs.interet,
            "propos" : utilisateurs.propos,

          });
          return "success";
      }catch(e){
        print(e);
        return "error";
      }

    }
}

