import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/ripple_animation.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> with TickerProviderStateMixin {

  LikeController likecontroller = LikeController();
  List<Utilisateurs> listutilisateurs = [];
  List<String> listId = [];
  bool isloading = true;
  late Utilisateurs currentUser;
  String idCurrentUser="";
  UtilisateurController utilisateurcontroller = UtilisateurController();
  DatabaseConnection connection = DatabaseConnection();

  @override
  initState(){
    getCurrentUser();
    getMyLike();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
  TabController _tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      body:  isloading ? const RippleAnimation() :  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
            children: [
              
              if(idCurrentUser.isNotEmpty)
                Align(
                  alignment: Alignment.topLeft,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: likecontroller.getUserLikeMe(idCurrentUser),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                      // print("dans like ${snapshot.data!.docs}");
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child:  Text("${snapshot.data!.docs.length} Likes",
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(
                              thickness: 0.8,
                            ),
                            Wrap(
                              spacing: 5,
                              runSpacing: 5,
                              children: [
                                for(int i=0; i<snapshot.data!.docs.length; i++)
                                  FutureBuilder<Utilisateurs>(
                                    future: utilisateurcontroller.getUserById2(snapshot.data!.docs[i].id),
                                    builder: (BuildContext context,  AsyncSnapshot<Utilisateurs> future) {
                                      if(future.hasData){
                                        Utilisateurs? utilisateurs = future.data ;
                                        return SizedBox(
                                          width: (size.width - 15) / 2,
                                          height: 250,
                                          child: Stack(
                                            children: [
                                              Container(
                                                key: UniqueKey(),
                                                width: (size.width - 15) / 2,
                                                height: 250,
                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: CachedNetworkImageProvider(
                                                      utilisateurs!.photo[0],
                                                      cacheManager: customCacheManager,
                                                    ),
                                                      fit: BoxFit.cover
                                                  ),
                                                  border: snapshot.data!.docs[i]['super'] ? Border.all(color: Colors.amber, width: 3, style: BorderStyle.solid) : null
                                                ),
                                              ),
                                              Container(
                                                width: (size.width - 15) / 2,
                                                height: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Colors.black.withOpacity(0.25),
                                                      Colors.black.withOpacity(0),
                                                    ],
                                                    end: Alignment.topCenter,
                                                    begin: Alignment.bottomCenter
                                                  )
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 15),
                                                      child: Row(
                                                        children: [
                                                          const SizedBox(width: 5 ),
                                                          Text("${utilisateurs.nom.capitalize()}, ${utilisateurs.age}}",
                                                                style: TextStyle(color: Colors.white, fontSize: size.width*0.05,),
                                                          )
                                                          // Text("${snapshot.data!.docs[i].id}",
                                                          //       style: TextStyle(color: Colors.white, fontSize: size.width*0.05,),
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          InkWell(
                                                            onTap: (){
                                                              likecontroller.updateLike(utilisateurs.idutilisateurs);
                                                            },
                                                            child: const CircleAvatar(
                                                              radius: 15,
                                                              child: Icon(Icons.close, size: 20, color: Colors.black),
                                                              backgroundColor: Colors.white,
                                                            ),
                                                          ),
                                                          const SizedBox(width: 5 ),
                                                          InkWell(
                                                            onTap: (){
                                                              onlike(utilisateurs);
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 15,
                                                              child: Icon(CupertinoIcons.heart_fill, size: 20, color: Theme.of(context).primaryColor),
                                                              backgroundColor: Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.pushNamed(context, profildetailsRoute, arguments: utilisateurs);
                                                },
                                                child: const Positioned(
                                                  top: 1,
                                                  left: 1,
                                                  child: Padding(
                                                    padding: EdgeInsets.all(8.0),
                                                    child: Icon(Icons.info, color: Colors.white,),
                                                  )
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }else{
                                        return Container();
                                      }
                                    }
                                  )
                              ],
                            ),
                          ],
                        );
                      }else{
                        return const Text("");
                      }
                    }
                  ),
                ),
            ],
          ),
          )
        ),
      ),
      
    );
  }

  void getMyLike() async {
    
    await likecontroller.getLikedMeUsers().then((value) async{
      setState(() {
        listutilisateurs= value;        
      });
    });

    setState(() {
      isloading = false;
    });
  }

  void onlike(Utilisateurs utilisateur) async {

    currentUser = await Utilisateurs.getCurrentUser();
    // sauvegarde du like en ligne
    Likes like = Likes(idSender: currentUser.idutilisateurs, idReceiver: utilisateur.idutilisateurs);
      likecontroller.findMacth(like, false).then((value){
      // sauvegarde du like en local
      likecontroller.updateLike(utilisateur.idutilisateurs);
      connection.ajouterLikes(like);    
          // print("resultats du match $value");
      });
  }

  void getCurrentId() {}

  void getCurrentUser() async {
    await Utilisateurs.getUserId().then((value){
      setState(() {
        idCurrentUser = value;
      });
    });
  }


}
