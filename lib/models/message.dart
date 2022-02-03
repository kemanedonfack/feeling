class Message{

  String idmessage;
  String idSender;
  String idReceiver;
  String content;
  String type;
  bool read;
  String date;

  Message({required this.idmessage, required this.idSender, required this.idReceiver, required this.content, required this.type, required this.read, required this.date});

  factory Message.fromMap(Map<String, dynamic> data, String id){
    return Message(
        idmessage: id,
        idSender: data['idSender'],
        idReceiver: data['idReceiver'],
        date: data['date'],
        content: data['content'],
        type: data['type'],
        read: data['read'],
    );
  }


}