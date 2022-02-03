import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/message_controller.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/conversations.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';
import 'composant/chat_users_list.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  

  LikeController likecontroller = LikeController();
  String idCurrentUser="";
  MessageController messagecontroller = MessageController();  
  UtilisateurController utilisateurcontroller = UtilisateurController();

  @override
  initState(){
    getIdCurrentUser();
    super.initState();
  }

  void getIdCurrentUser() async {

    await Utilisateurs.getUserId().then((value){
      setState(() {
        idCurrentUser = value;       
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SafeArea (
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16,top: 10, bottom: 10),
                child: Text("Messages",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16,right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade400),
                  prefixIcon: Icon(Icons.search,color: Colors.grey.shade400,size: 20,),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade100
                      )
                  ),
                ),
              ),
            ),
            const SafeArea (
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16, bottom: 10),
                child: Text("Matchs",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            if(idCurrentUser.isNotEmpty)
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(C_RELATIONS).doc(idCurrentUser).collection(C_MATCHS).orderBy('date', descending: true).snapshots(),
                builder: (context, snapshot) {
                  // print("donne $idCurrentUser de match ${snapshot.data!.docs[0].id}");
                  if(snapshot.hasData){
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for(int i=0; i<snapshot.data!.docs.length; i++)
                            FutureBuilder<Utilisateurs>(
                              future: utilisateurcontroller.getUserById2(snapshot.data!.docs[i].id),
                              builder: (BuildContext context,  AsyncSnapshot<Utilisateurs> snapshot) {
                                if(snapshot.hasData){
                                  Utilisateurs? utilisateurs = snapshot.data ;
                                  return InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, chatDetailsRoute, arguments: utilisateurs);
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                      child: CircleAvatar(
                                        backgroundImage: CachedNetworkImageProvider(
                                          utilisateurs!.photo[0],
                                          cacheManager: customCacheManager,
                                        ),
                                        maxRadius: 30,
                                      ),
                                    ),
                                  );
                                }else{
                                  return const Text("");
                                }
                                
                              }
                            )
                        ]
                      )
                    );
                  }else{
                    return const Text("");
                  }
                }
              ),
            const SafeArea (
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16, bottom: 10),
                child: Text("Conversations",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            if(idCurrentUser.isNotEmpty)
              StreamBuilder<List<Conversation>>(
                stream: messagecontroller.getConversation(idCurrentUser, 20),

                builder: (BuildContext context, AsyncSnapshot<List<Conversation>> snapshot) {
                 
                  
                  if(snapshot.hasData){
                    List<Conversation> listconversation = snapshot.data ?? List.from([]);
                    return ListView.builder(
                      itemCount: listconversation.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 16),
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index){
                        return ChatUsersList(conversation: listconversation[index],);
                      },
                    );
                  }else{
                    return const Text("");
                  }
                }
              ),
          ],
        ),
      ),
    );
  }

  // void getMatchs() async {

  //   idCurrentUser = await Utilisateurs.getUserId();
    
  //   await likecontroller.getMeMatchs().then((value){
  //     setState(() {
  //       listmatchs = value;
  //     });
  //   });
  //   print("mes matchs $listmatchs");

  // }

}