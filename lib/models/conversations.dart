class Conversation{

  String id;
  List<dynamic> userIds;
  Map<dynamic, dynamic> lastMessage;

  Conversation({required this.id, required this.userIds, required this.lastMessage});


  factory Conversation.fromMap(Map<String, dynamic> data, String id){
    return Conversation(
        id: id,
        userIds: data['users'] ,
        lastMessage: data['lastMessage']
    );
  }



}