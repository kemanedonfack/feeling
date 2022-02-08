// ignore_for_file: must_be_immutable

import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/conversations.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';

class ChatUsersList extends StatefulWidget{

  Conversation conversation;

  ChatUsersList({Key? key, required this.conversation}) : super(key: key);
  @override
  _ChatUsersListState createState() => _ChatUsersListState();
}

class _ChatUsersListState extends State<ChatUsersList> {

  UtilisateurController utilisateurcontroller = UtilisateurController();

  @override
  void initState() {
    getUsersId();
    super.initState();
  }

  bool read=false;
  String userId="";

    
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Utilisateurs>(
      future: utilisateurcontroller.getUserById(widget.conversation.userIds),
      builder: (BuildContext context,  AsyncSnapshot<Utilisateurs> snapshot) {
        if(snapshot.hasData){
          Utilisateurs? utilisateurs = snapshot.data ;
          return GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, chatDetailsRoute, arguments: utilisateurs as Utilisateurs);
            },
            child: Container(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children:  <Widget>[
                        Stack(
                          children: [
                            CircleAvatar(
                              backgroundImage: CachedNetworkImageProvider(
                                utilisateurs!.photo[0],
                                cacheManager: customCacheManager,
                              ),
                              maxRadius: 30,
                              child: StreamBuilder<DocumentSnapshot>(
                                stream: utilisateurcontroller.getUserStatus(utilisateurs.idutilisateurs),
                                builder: (context, snapshot) {
                                  if(snapshot.hasData){
                                    if(snapshot.data!.exists){
                                      if(snapshot.data!['online'] == true){
                                        return Badge(
                                          badgeColor: Colors.green,
                                          position:  BadgePosition.bottomEnd(bottom: 3.0, end: 3.0),
                                          child: Container(),
                                        );
                                      }else{
                                        return Container();
                                      } 
                                      
                                    }else{
                                      return Container();
                                    }
                                  }else{
                                    return Container();
                                  }
                                  
                                }
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16,),
                        Expanded(
                          child: Container(
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(utilisateurs.nom.capitalize()),
                                const SizedBox(height: 6,),
                                Text(widget.conversation.lastMessage['content'],style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      
                      Text(readTimestamp(int.parse(widget.conversation.lastMessage['date'])), style: TextStyle(fontSize: 12, color: read ? Colors.grey.shade500 : Colors.pink ),),
                      messageIsRead() 
                    ],
                  ),
                ],
              ),
            ),
          );
        }else{
          return const Text("");
        }
      }
    );
  }

  getUsersId() async {
    await Utilisateurs.getUserId().then((value){
      setState(() {
        userId = value;
      });
    });
  }

  Widget messageIsRead() {

    if(userId.isNotEmpty && widget.conversation.lastMessage['idReceiver'] == userId){
      if(widget.conversation.lastMessage['read'] == true){
        return const Text("");
      }else{
        return Padding(
        padding: const EdgeInsets.fromLTRB(0,8,0,0),
        child: CircleAvatar(
          radius: 9,
          child: const Text('1',style: TextStyle(fontSize: 12),),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          )
        );
      }
    }else{
      return const Text("");
    }
  }  

}