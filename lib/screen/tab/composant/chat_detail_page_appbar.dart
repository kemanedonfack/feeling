import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/message_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';

class ChatDetailPageAppBar extends StatelessWidget implements PreferredSizeWidget{
  // const ChatDetailPageAppBar({Key? key}) : super(key: key);
  
  final Utilisateurs utilisateurs;
  final String conversationsId;
  const ChatDetailPageAppBar(this.utilisateurs, this.conversationsId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      flexibleSpace: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back,color: Colors.black,),
              ),
              const SizedBox(width: 2,),
              InkWell(
                onTap: (){
                  Navigator.pushNamed(context, profildetailsRoute, arguments: utilisateurs);
                },
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    utilisateurs.photo[0],
                    cacheManager: customCacheManager,
                  ),
                  maxRadius: 30,
                ),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(utilisateurs.nom.capitalize(), style: const TextStyle(fontWeight: FontWeight.w600),),
                    const SizedBox(height: 6,),
                    const Text("Online",style: TextStyle(color: Colors.green,fontSize: 12),),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                itemBuilder: (context) => <PopupMenuEntry<String>> [
                  const PopupMenuItem(
                    value: "delete_chat",
                    child: Text("Supprimer la conversation")
                  ),
                  const PopupMenuItem(
                    value: "delete_match",
                    child: Text("Supprimer le match")
                  ),                  
                ],
                onSelected: (val){
                  switch (val) {
                    case "delete_chat":
                      deleteChat(context);
                      break;
                    case "delete_match":
                      deleteMatch(context);
                      break;
                  }

                },
              ),
              // Icon(Icons.more_vert,color: Colors.grey.shade700,),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteChat(BuildContext context){
    
    MessageController messagecontroller = MessageController();
    
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: Text("Vous voulez vraiment supprimer votre conversation avec ${utilisateurs.nom.capitalize()} ?"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  messagecontroller.deleteChat(conversationsId);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OUI"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("NON"),
              )
            ],
          );
        }
    );
  }

  Future<void> deleteMatch(BuildContext context){

    LikeController likecontroller = LikeController();

    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: Text("Vous voulez vraiment supprimer votre match avec ${utilisateurs.nom.capitalize()} ? "),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  likecontroller.deleteMatch(utilisateurs.idutilisateurs);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("OUI"),
              ),
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("NON"),
              )
            ],
          );
        }
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}