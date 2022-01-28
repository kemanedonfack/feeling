import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/models/like.dart';
import 'package:flutter/foundation.dart';


class LikeController{
  
  CollectionReference likes  = FirebaseFirestore.instance.collection('likes');
  CollectionReference matchs  = FirebaseFirestore.instance.collection('matchs');
  CollectionReference relations  = FirebaseFirestore.instance.collection('relations');

    Future<bool> findMacth(Likes like) async {
      bool result = false;
      try{
          var documentIdLike = likes.doc().id;
          
          await likes
                .where('idReceiver', isEqualTo: like.idSender)
                .where('idSender', isEqualTo: like.idReceiver)
                .get().then((querySnapshot) async {
                  
                  if(querySnapshot.docs.isEmpty){
                    // si aucun des deuc n'a liker le profil de l'autre
                    // on ajoute le like dans la base de données
                    await likes.doc(documentIdLike).set({
                      "idSender" : like.idSender,
                      "idReceiver" : like.idReceiver,
                    });

                    result = false;

                  }else{
                    // si l'un des deux à liker la photo de l'autre
                    // on ajoute le like dans la base de données
                    await likes.doc(documentIdLike).set({
                      "idSender" : like.idSender,
                      "idReceiver" : like.idReceiver,
                    });

                    // on créer un match
                    await relations.doc(like.idSender).collection("matchs").doc(like.idReceiver).set({
                      "date": FieldValue.serverTimestamp()
                    });

                    await relations.doc(like.idReceiver).collection("matchs").doc(like.idSender).set({
                      "date": FieldValue.serverTimestamp()
                    });

                    if(kDebugMode) {
                      print("nombre d'element trouvé ${querySnapshot.docs.length}");
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

