import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/models/conversations.dart';
import 'package:feeling/models/message.dart';

class MessageController{

  CollectionReference relations  = FirebaseFirestore.instance.collection(C_RELATIONS);
  CollectionReference users  = FirebaseFirestore.instance.collection(C_USERS);
  CollectionReference conversations  = FirebaseFirestore.instance.collection(C_CONVERSATIONS);
  
  Future<void> updateReadMessage(String conversationId, String messageId ) async {

    conversations.doc(conversationId).update({
      'lastMessage.read': true
    });

    conversations.doc(conversationId).collection(C_MESSAGES).doc(messageId).update({
      'read': true
    });

  }

  Future<void> deleteChat(String conversationsId) async {
    conversations.doc(conversationsId).delete();
  }

  Stream<List<Conversation>> getConversation(String currentUserId, int limit) {
    return FirebaseFirestore.instance.collection(C_CONVERSATIONS).orderBy('lastMessage.date', descending: true)
                    .where('users', arrayContains: currentUserId).snapshots().map(_conversationListFromSnapshot);
  }

  Stream<List<Message>> getMessage(String groupChatId, int limit) {
    return FirebaseFirestore.instance.collection(C_CONVERSATIONS).doc(groupChatId)
                   .collection(C_MESSAGES).orderBy('date', descending: true).limit(limit)
                   .snapshots().map(_messageListFromSnapshot);
  }
 
  void sendMessage(String groupChatId, Message message) {

    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection(C_CONVERSATIONS).doc(groupChatId);

    documentReference.set({
      'lastMessage': {
        'idSender': message.idSender,
        'idReceiver': message.idReceiver,
        'content': message.content,
        'type': message.type,
        'read': false,
        'date': DateTime.now().millisecondsSinceEpoch.toString()
      },
      'users':[message.idSender, message.idReceiver]
    }).then((value){

      final DocumentReference messageDoc = FirebaseFirestore.instance
            .collection(C_CONVERSATIONS)
            .doc(groupChatId).collection(C_MESSAGES)
            .doc(DateTime.now().millisecondsSinceEpoch.toString());

      
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(messageDoc, {
          'idSender': message.idSender,
          'idReceiver': message.idReceiver,
          'content': message.content,
          'type': message.type,
          'read': false,
          'date': DateTime.now().millisecondsSinceEpoch.toString()
        });
      });
    });    

  }


  List<Conversation> _conversationListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _conversationFromSnapshot(doc);
    }).toList();
  }

  Conversation _conversationFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Conversation.fromMap(data, snapshot.id);
  }

  List<Message> _messageListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _messageFromSnapshot(doc);
    }).toList();

  }  

  Message _messageFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Message.fromMap(data, snapshot.id);
  }

}
