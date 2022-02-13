import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';

import 'notification_controller.dart';


class LikeController{
  
  CollectionReference likes  = FirebaseFirestore.instance.collection(C_LIKES);
  CollectionReference matchs  = FirebaseFirestore.instance.collection(C_MATCHS);
  CollectionReference relations  = FirebaseFirestore.instance.collection(C_RELATIONS);
  CollectionReference users  = FirebaseFirestore.instance.collection(C_USERS);

  Future<void> updateMatch(String matchedUserId ) async {

    await relations.doc(await Utilisateurs.getUserId()).collection(C_MATCHS).doc(matchedUserId).set({
      'active': true
    });
    
    await relations.doc(matchedUserId).collection(C_MATCHS).doc(await Utilisateurs.getUserId()).set({
      'active': true
    });

  }
  
  Future<void> deleteMatch(String matchedUserId) async {
    
    await relations.doc(await Utilisateurs.getUserId()).collection(C_MATCHS).doc(matchedUserId).delete();
    
    await relations.doc(matchedUserId).collection(C_MATCHS).doc(await Utilisateurs.getUserId()).delete();
  }

  
  
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

    Future<bool> findMacth(Likes like, bool isSuperLike) async {
      bool result = false;
      try{
        await relations.doc(like.idSender).collection(C_LIKES).doc(like.idReceiver)
          .get().then((querySnapshot) async {
                  
            if(!querySnapshot.exists){
              // si aucun des deux n'a liker le profil de l'autre
              // on ajoute le like dans la base de données
              await relations.doc(like.idReceiver).collection(C_LIKES).doc(like.idSender).set({
                "read": false,
                "super": isSuperLike,
                "date": FieldValue.serverTimestamp()
              });

              result = false;

            }else{
              // si l'un des deux à liker la photo de l'autre
              // on ajoute le like dans la base de données
              await relations.doc(like.idReceiver).collection(C_LIKES).doc(like.idSender).set({
                "read": false,
                "super": false,
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

  // Future<void>saveDisLike(Likes dislike) async {
  //   await relations.doc(dislike.idSender).collection(C_DISLIKES).doc(dislike.idReceiver).set({
  //     "date": FieldValue.serverTimestamp()
  //   });
  // }

  Future<void>saveSuperLike(Likes superlike) async {
    await relations.doc(superlike.idReceiver).collection(C_LIKES).doc(superlike.idSender).set({
      "read": false,
      "super": true,
      "date": FieldValue.serverTimestamp()
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserLikeMe(String id){
    return FirebaseFirestore.instance.collection(C_RELATIONS).doc(id).collection(C_LIKES).where('read', isEqualTo: false).orderBy('date', descending: true).snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMeSuperLike(String id){
    return FirebaseFirestore.instance.collection(C_RELATIONS).doc(id).collection(C_LIKES).where('read', isEqualTo: false).where('super', isEqualTo: true).orderBy('date', descending: true).snapshots();
  }

  Future<void> updateLike(String likeUserId) async {
    await relations.doc(await Utilisateurs.getUserId()).collection(C_LIKES).doc(likeUserId).update({
      'read': true
    });
    await relations.doc(likeUserId).collection(C_LIKES).doc(await Utilisateurs.getUserId()).update({
      'read': true
    });
  }
}
