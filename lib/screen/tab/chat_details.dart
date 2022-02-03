// ignore_for_file: constant_identifier_names

import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/message_controller.dart';
import 'package:feeling/models/message.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/screen/tab/composant/chat_bubble.dart';
import 'package:feeling/screen/tab/composant/chat_detail_page_appbar.dart';
import 'package:flutter/material.dart';


enum MessageType{
  text,
  image,
}

class ChatDetailScreen extends StatefulWidget{

  final Utilisateurs utilisateurs;
  const ChatDetailScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
 
  String chatGroupId = "";
  MessageController messagecontroller = MessageController();  
  LikeController likeController = LikeController();
  TextEditingController textEditingController = TextEditingController();
  ScrollController listScrollController = ScrollController();

  int _nbElement = 20;
  static const int PAGINATION_INCREMENT = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getChatGroupId();
    listScrollController.addListener(_scrollListener);
  }

  activeMacth(){
    likeController.updateMatch(widget.utilisateurs.idutilisateurs);
  }

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _nbElement += PAGINATION_INCREMENT;
      });
    }
  }

  void showModal(){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height/3,
          color: const Color(0xff737373),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                Center(
                  child: Container(
                    height: 4,
                    width: 50,
                    color: Colors.grey.shade200,
                  ),
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.amber.shade50,
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(Icons.image ,size: 20,color: Colors.amber.shade400,),
                    ),
                    title: const Text("Gallerie"),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10,bottom: 10),
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.blue.shade50,
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(Icons.camera_alt ,size: 20,color: Colors.blue.shade400,),
                    ),
                    title: const Text("Caméra"),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatDetailPageAppBar(widget.utilisateurs, chatGroupId),
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              if(chatGroupId.isNotEmpty)
                Flexible(
                  child: StreamBuilder<List<Message>>(
                    stream: messagecontroller.getMessage(chatGroupId, _nbElement),
                    builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
                      
                      if(snapshot.hasData){
                        List<Message> listmessage = snapshot.data ?? List.from([]);
                        
                        return ListView.builder(
                          itemCount: listmessage.length,
                          reverse: true,
                          controller: listScrollController,
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          itemBuilder: (context, index){
                          return ChatBubble(message: listmessage[index], chatGroupId: chatGroupId);
                          },
                        );
                      }else{
                        return const Text("");
                      }                
                
                    },
                  ),
                ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: Container(
              //     padding: const EdgeInsets.only(right: 30,bottom: 0),
              //     child: FloatingActionButton(
              //       onPressed: (){
              //         sendMessage(textEditingController.text, 'text');
              //       },
              //       child: const Icon(Icons.send,color: Colors.white,),
              //       backgroundColor: Theme.of(context).primaryColor,
              //       elevation: 0,
              //     ),
              //   ),
              // ),
              Container(
                padding: const EdgeInsets.only(left: 16,bottom: 0),
                height: 80,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: (){
                        showModal();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.photo,color: Colors.white,size: 21,),
                      ),
                    ),
                    const SizedBox(width: 16,),
                    Flexible(
                      child: TextFormField(
                        minLines: 1,
                        maxLines: 10,
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: "Message...",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(1),
                        ),
                    ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 30,bottom: 0),
                      child: FloatingActionButton(
                        onPressed: (){
                          sendMessage(textEditingController.text, 'text');
                        },
                        child: const Icon(Icons.send,color: Colors.white,),
                        backgroundColor: Theme.of(context).primaryColor,
                        elevation: 0,
                      ),
                    )
                  ],
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }

  getChatGroupId() async {

    await Utilisateurs.getUserId().then((value) {
      if (value.hashCode <= widget.utilisateurs.idutilisateurs.hashCode) {
        setState(() {
          chatGroupId = value+'-'+widget.utilisateurs.idutilisateurs; 
        });
      } else {
        setState(() {
          chatGroupId = widget.utilisateurs.idutilisateurs+'-'+value;
        });
      }
    });
    
  }

  
  void sendMessage(String content, String type) async{
    activeMacth();
    
    if(content.trim() != '' && chatGroupId.isNotEmpty){
    
      Message message = Message(idSender: await Utilisateurs.getUserId(), content: content, date: DateTime.now().millisecondsSinceEpoch.toString(), 
      idReceiver: widget.utilisateurs.idutilisateurs, type: type, read: false, idmessage: '');
      messagecontroller.sendMessage(chatGroupId, message);
    
      
      listScrollController.animateTo(0.0, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      textEditingController.clear();
    }
    

  }





}
