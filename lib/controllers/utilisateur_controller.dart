import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';


class UtilisateurController{
  
  CollectionReference users  = FirebaseFirestore.instance.collection('users');

    Future<List<Utilisateurs>> getFiltersUsers(String sexe, double minage, double maxage, String ville) async {

      List<Utilisateurs> listutilisateurs = [];
      if (kDebugMode) {
        print("dans le controller");
      }

      await users
        .where('age', isLessThanOrEqualTo: maxage)
        .where('age', isGreaterThanOrEqualTo: minage)
        // .where('age', isEqualTo: minage)
        .where('ville', isEqualTo: ville)
        .where('sexe', isEqualTo: sexe)
        .get().then((querySnapshot){
          for (var element in querySnapshot.docs) {
            if (kDebugMode) {
              print(element.data());
            }
              listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
          }
        });

      return listutilisateurs;
    }

    Future<List<Utilisateurs>> getAllUsers() async {

      List<Utilisateurs> listutilisateurs = [];
      if (kDebugMode) {
        print("dans le controller");
      }
     
      await users.get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          if (kDebugMode) {
            print(element.data());
          }
            listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
         }
      });

      return listutilisateurs;
    }

    Future<String> addUsers(Utilisateurs utilisateurs) async {

      try{
        if (kDebugMode) {
          print("pret");
        }

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
        if (kDebugMode) {
          print(e);
        }
        return "error";
      }

    }
}

