import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';
import 'package:location/location.dart';


class UtilisateurController{
  
  CollectionReference users  = FirebaseFirestore.instance.collection(C_USERS);
  
    Future<List<Utilisateurs>> getFiltersUsers(String sexe, double minage, double maxage, String ville) async {

      List<Utilisateurs> listutilisateurs = [];
      if (kDebugMode) {
        print("dans le controller");
      }
 
      await users
        .where('age', isLessThanOrEqualTo: maxage)
        .where('age', isGreaterThanOrEqualTo: minage)
        .where('ville', isEqualTo: ville)
        .where('sexe', isEqualTo: sexe)
        .orderBy('age')
        .orderBy('date_creation')
        .get().then((querySnapshot){
          for (var element in querySnapshot.docs) {
            if (kDebugMode) {
              print(element.data());
            }
              listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
          }
        });

      return removerCurrentUsers(listutilisateurs);
    }

    Future<List<Utilisateurs>> getAllUsers(String sexe) async {

      List<Utilisateurs> listutilisateurs = [];
      if (kDebugMode) {
        print("dans le controller");
      }
     
      await users.where("sexe", isNotEqualTo: sexe)
        .orderBy('sexe')
        .orderBy('date_creation', descending: true).get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
          if (kDebugMode) {
            print(element.data());
          }
            listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
         }
      });
      
     return removerCurrentUsers(listutilisateurs);
    }

    Future<String> addUsers(Utilisateurs utilisateurs, LocationData locationData) async {

      try{
        if (kDebugMode) {
          print("pret");
        }
          
          var documentId = users.doc().id;
          
          await users.doc(documentId).set({
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
            "localisation": GeoPoint(locationData.latitude as double, locationData.longitude as double),
            "date_creation": FieldValue.serverTimestamp(),
            "status": "active"
          });
          return documentId;
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        return "error";
      }

    }

    Future<List<Utilisateurs>> removerCurrentUsers(List<Utilisateurs> listutilisateurs) async {

      String idusers = await Utilisateurs.getUserId();
      // retire utilisateurs courant de la liste
      if(listutilisateurs.isNotEmpty){
        listutilisateurs.removeWhere((element) => element.idutilisateurs == idusers);
      }

      return listutilisateurs;
    }
}

