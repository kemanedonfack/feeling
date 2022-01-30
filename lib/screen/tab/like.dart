// ignore_for_file: dead_code

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/ripple_animation.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/material.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({Key? key}) : super(key: key);

  @override
  _LikeScreenState createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {

  LikeController likecontroller = LikeController();
  List<Utilisateurs> listutilisateurs = [];
  List<String> listId = [];
  bool isloading = true;

  @override
  initState(){
    getMyLike();
    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
      body:  isloading ? const RippleAnimation() :  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 10),
                  child: Text(
                    "${listutilisateurs.length} Likes ",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 0.8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    spacing: 5,
                    runSpacing: 5,
                    children: List.generate(listutilisateurs.length, (index)  {
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, profildetailsRoute, arguments: listutilisateurs[index]);
                        },
                        child: SizedBox(
                          width: (size.width - 15) / 2,
                          height: 250,
                          child: Stack(
                            children: [
                              Container(
                                key: UniqueKey(),
                                width: (size.width - 15) / 2,
                                height: 250,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  // image: DecorationImage(
                                  //   image: NetworkImage((listutilisateurs[index].photo[0])),
                                  //   fit: BoxFit.cover
                                  // )
                                  image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      listutilisateurs[index].photo[0],
                                      cacheManager: customCacheManager,
                                    ),
                                    // image: NetworkImage(listutilisateurs[index].photo[0]),
                                      fit: BoxFit.cover
                                  ),
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
                                      padding: const EdgeInsets.only(left: 8, bottom: 8),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 5 ),
                                          Text("${listutilisateurs[index].nom.capitalize()}, ${listutilisateurs[index].age}",
                                                style: TextStyle(color: Colors.white, fontSize: size.width*0.05,),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                )
              ],
            ),
          )
        ),
      ),
      
    );
  }

  void getMyLike() async {
    UtilisateurController controller = UtilisateurController();
    await likecontroller.getLikedMeUsers().then((value) async{
      setState(() {
        listutilisateurs= value;        
      });
    });

    setState(() {
      isloading = false;
    });
  }

}
