import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/controllers/notification_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/filtres.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UtilisateurController{
  
  CollectionReference users  = FirebaseFirestore.instance.collection(C_USERS);
  CollectionReference gains  = FirebaseFirestore.instance.collection(C_GAINS);
  CollectionReference codes  = FirebaseFirestore.instance.collection(C_CODES);
  DatabaseConnection connection = DatabaseConnection();
  NotificationController notificationController = NotificationController();

  void sendBooster(int code) async {
    await codes.where('code', isEqualTo: code).get().then((querySnapshot){
      for (var element in querySnapshot.docs) {
        gains.doc(element.id).update({
          'booster': FieldValue.increment(1)
        });
      }
    });
  }
  
  void updateCountry(Utilisateurs utilisateurs) async {

    users.doc(utilisateurs.idutilisateurs).update({
      "ville" : utilisateurs.ville,
      "pays" : utilisateurs.pays,
    });
    
    connection.deleteInteret().then((value){
      connection.ajouterInteret(utilisateurs.interet);
    });

  }
  
  void superLike(String idusers) async {
    
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    gains.doc(idusers).update({
      'superLike': _prefs.getInt('superLike')!-1
    });
  }

  Future<void> endBooster(String idusers) async {
    
    return users.doc(idusers).update({ 'booster': 0});
  }

  void booster(String idusers) async {
    
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    users.doc(idusers).update({
      'booster': 1
    });
    gains.doc(idusers).update({
      'booster': _prefs.getInt('booster')!-1
    });
  }

  void updateUtilisateurs(Utilisateurs utilisateurs) async {
      
    await users.doc(utilisateurs.idutilisateurs).update({
      "nom" : utilisateurs.nom,
      "age" : utilisateurs.age,
      "ville" : utilisateurs.ville,
      "pays" : utilisateurs.pays,
      "profession" : utilisateurs.profession,
      "numero" : utilisateurs.numero,
      "photo" : utilisateurs.photo,
      "interet" : utilisateurs.interet,
      "propos" : utilisateurs.propos,
      "etablissement" : utilisateurs.etablissement,
      "email" : utilisateurs.email,
      "token": await notificationController.getToken()
    });

    await connection.deleteInteret().then((value){
      connection.ajouterInteret(utilisateurs.interet);
    });

  }
  
  void updateInteret(Utilisateurs utilisateurs) async {

    users.doc(utilisateurs.idutilisateurs).update({
      "interet" : utilisateurs.interet,
    });
    connection.deleteInteret().then((value){
      connection.ajouterInteret(utilisateurs.interet);
    });

  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStatus(String id){
    return FirebaseFirestore.instance.collection(C_USERS).doc(id).snapshots();
  }

    Future<Utilisateurs>getUserById(List<dynamic> idusers) async {
      
      String idcurrentuser = await Utilisateurs.getUserId();
      
      idusers.removeWhere((element) => element == idcurrentuser);
      
      late Utilisateurs utilisateurs;

      await users.doc(idusers[0]).get().then((value){
        utilisateurs = Utilisateurs.fromMap(value.data() as Map<String, dynamic>, value.id);
      });

      return utilisateurs;
    }

    Future<List<Utilisateurs>> getAllUsers(Filtres filtre) async {

      List<Utilisateurs> listutilisateurs = [];
            
      await users
        .where('age', isLessThanOrEqualTo: filtre.maxAge)
        .where('age', isGreaterThanOrEqualTo: filtre.minAge)
        .where('ville', isEqualTo: filtre.ville)
        .where("sexe", isEqualTo: filtre.sexe)
        .where('pays', isEqualTo: filtre.pays)
        .orderBy('age')
        .orderBy('date_creation', descending: true)
        .limit(20)
        .get().then((querySnapshot){
        for (var element in querySnapshot.docs) {
            listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
        }
      });

      if (kDebugMode) {
        print("list utilisateurs initiale $listutilisateurs");
      }

      if(filtre.showDislike == true){
        var dislikedUsers = await connection.getLikeAndDisLike('dislikes');
        /// retrait des utilisateurs que j'aime pas 
        if (dislikedUsers.isNotEmpty) {
          dislikedUsers.forEach((dislikedUser) {
            listutilisateurs.removeWhere(
                (userDoc) => userDoc.idutilisateurs == dislikedUser['idReceiver']);
          });
        }
      }
      

      var likedUsers = await connection.getLikeAndDisLike('likes');
        /// retrait des utilisateurs que j'aime  
      if (likedUsers.isNotEmpty) {
        likedUsers.forEach((likedUser) {
          listutilisateurs.removeWhere(
              (userDoc) => userDoc.idutilisateurs == likedUser['idReceiver']);
        });
      }
      if (kDebugMode) {
        print("list utilisateurs apres retrait $listutilisateurs");
      }
      // return listutilisateurs;
      return removerCurrentUsers(listutilisateurs);
    }
    
    Future<DocumentSnapshot> getGains(String idusers) async{

      return await gains.doc(idusers).get();
    }
    
    Future<String> addUsers(Utilisateurs utilisateurs) async {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      try{
        if (kDebugMode) {
          print("pret");
        }
          
          String documentId ="";
          
          await users.add({
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
            "localisation": GeoPoint(utilisateurs.position.latitude as double, utilisateurs.position.longitude as double),
            "date_creation": FieldValue.serverTimestamp(),
            "status": "active",
            "online": true,
            "booster": 0,
            "token": await notificationController.getToken()
          }).then((value) {
            documentId = value.id;
            return value.id;
          });

          gains.doc(documentId).set({
            "superLike": 1,
            "booster": 1,
          });

          codes.doc(documentId).set({
            'code': documentId.hashCode
          });

          _prefs.setString("idusers", documentId);
          _prefs.setInt("referralCode", documentId.hashCode);
          
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

  Future<Utilisateurs>getUserById2(String id) async {
      
    late Utilisateurs utilisateurs;
        
    await users.doc(id).get().then((value){
      // print("val ${value.data()}");
      utilisateurs = Utilisateurs.fromMap(value.data() as Map<String, dynamic>, value.id);
    });

    return utilisateurs;
  }
}

