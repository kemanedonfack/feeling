import 'package:feeling/controllers/message_controller.dart';
import 'package:feeling/models/message.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatefulWidget{
  
  final Message message;
  final String chatGroupId;
  const ChatBubble({Key? key, required this.message, required this.chatGroupId}) : super(key: key);
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {

  String idCurrentUsers="";
  MessageController messagecontroler =  MessageController();

  @override
  initState(){
    getCurrentUsersId();
    updateLastRead();
    super.initState();
  }

  updateLastRead() async {
    
    
  }

  void getCurrentUsersId() async {

    await Utilisateurs.getUserId().then((value){
      setState(() {
        idCurrentUsers = value;
        
          if(idCurrentUsers == widget.message.idReceiver){
            messagecontroler.updateReadMessage(widget.chatGroupId, widget.message.idmessage);
          }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if(idCurrentUsers.isNotEmpty){
      return Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Align(
          alignment: (widget.message.idSender == idCurrentUsers ? Alignment.topRight : Alignment.topLeft),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: (widget.message.idSender  == idCurrentUsers ? Colors.white:Colors.grey.shade200),
            ),
            padding: const EdgeInsets.all(16),
            child: Text(widget.message.content),
          ),
        ),
      );
    }else{
      return Container();
    }
  }
}