import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';


class LikeController{
  
  CollectionReference likes  = FirebaseFirestore.instance.collection(C_LIKES);
  CollectionReference matchs  = FirebaseFirestore.instance.collection(C_MATCHS);
  CollectionReference relations  = FirebaseFirestore.instance.collection(C_RELATIONS);
  CollectionReference users  = FirebaseFirestore.instance.collection(C_USERS);

  Future<List<Utilisateurs>> getMeMatchs() async {

    List<String> listId = [];
    List<Utilisateurs> listutilisateurs = [];
    String idusers = await Utilisateurs.getUserId();
    await relations.doc(idusers).collection(C_MATCHS).orderBy('date', descending: true).get()
    .then((querySnapshot) async {

        if(querySnapshot.docs.isNotEmpty){
          
          for (var element in querySnapshot.docs) {
            if (kDebugMode) {
              print("matchs ${element.data()} id ${element.id}");
              listId.add(element.id);
            }
          }
          
          await users.where(FieldPath.documentId, whereIn: listId).get().then((querySnapshot){
            for (var element in querySnapshot.docs) {
              if (kDebugMode) {
                print(element.data());
              }
              listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
            }

          });
        }
      });

    return listutilisateurs;
  }

  Future<List<Utilisateurs>> getLikedMeUsers() async {

    List<String> listId = [];
    List<Utilisateurs> listutilisateurs = [];
    String idusers = await Utilisateurs.getUserId();
    await relations.doc(idusers).collection(C_LIKES).orderBy('date', descending: true).get()
    .then((querySnapshot) async {

        if(querySnapshot.docs.isNotEmpty){

          for (var element in querySnapshot.docs) {
            if (kDebugMode) {
              print("donnée ${element.data()} id ${element.id}");
              listId.add(element.id);
            }
          }
          
          await users.where(FieldPath.documentId, whereIn: listId).get().then((querySnapshot){
            print("ididi ${querySnapshot.docs.length}");
            for (var element in querySnapshot.docs) {
              if (kDebugMode) {
                print(element.data());
              }
              listutilisateurs.add(Utilisateurs.fromMap(element.data() as Map<String, dynamic>, element.id));
            }

          });
        }
      });

    return listutilisateurs;
  }

    Future<bool> findMacth(Likes like) async {
      bool result = false;
      try{
        
        await relations.doc(like.idSender).collection(C_LIKES).doc(like.idReceiver)
          .get().then((querySnapshot) async {
                  
            if(!querySnapshot.exists){
              // si aucun des deux n'a liker le profil de l'autre
              // on ajoute le like dans la base de données
              await relations.doc(like.idReceiver).collection(C_LIKES).doc(like.idSender).set({
                "date": FieldValue.serverTimestamp()
              });

              if (kDebugMode) {
                print("Ajout du like");
              }

                result = false;

            }else{
              if (kDebugMode) {
                print("Ajout du match");
              }
              // si l'un des deux à liker la photo de l'autre
              // on ajoute le like dans la base de données
              await relations.doc(like.idReceiver).collection(C_LIKES).doc(like.idSender).set({
                "date": FieldValue.serverTimestamp()
              });

              // on créer un match
              await relations.doc(like.idSender).collection(C_MATCHS).doc(like.idReceiver).set({
                "date": FieldValue.serverTimestamp(),
                "active": false
              });

              await relations.doc(like.idReceiver).collection(C_MATCHS).doc(like.idSender).set({
                "date": FieldValue.serverTimestamp(),
                "active": false
              });

              if(kDebugMode) {
                print("nombre d'element trouvé ${querySnapshot.exists}");
              }
              result = true;
            }
          }
        );
        return result;
      }catch(e){
        if (kDebugMode) {
          print(e);
        }
        return false;
      }

    }
}

