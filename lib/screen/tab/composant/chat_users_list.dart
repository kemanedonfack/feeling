// ignore_for_file: must_be_immutable

import 'package:feeling/screen/tab/chat_details.dart';
import 'package:flutter/material.dart';

class ChatUsersList extends StatefulWidget{
  
  String text;
  String secondaryText;
  String image;
  String time;
  bool isMessageRead;
  ChatUsersList({Key? key, required this.text, required this.secondaryText, required this.image, required this.time, required this.isMessageRead}) : super(key: key);
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const ChatDetailScreen();
        }));
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children:  <Widget>[
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.image),
                    maxRadius: 30,
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.text),
                          const SizedBox(height: 6,),
                          Text(widget.secondaryText,style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Text(widget.time,style: TextStyle(fontSize: 12,color: widget.isMessageRead?Colors.pink:Colors.grey.shade500),),
                widget.isMessageRead ? Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                  child: CircleAvatar(
                    radius: 9,
                    child: const Text('1',style: TextStyle(fontSize: 12),),
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                  )
                ) : const Text(""),
              ],
            ),
          ],
        ),
      ),
    );
  }
}