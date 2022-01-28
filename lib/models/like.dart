class Likes{

  String idSender;
  String idReceiver;

  Likes({required this.idSender, required this.idReceiver});

  factory Likes.fromMap(Map<String, dynamic> data, dynamic id){
    return Likes(
        idSender: data['idSender'],
        idReceiver: data['idReceiver'],
    );
  }
}