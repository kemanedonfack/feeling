import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feeling/models/utilisateurs.dart';

class ProfileDetailScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const ProfileDetailScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _ProfileDetailScreenState createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {

  LikeController likecontroller = LikeController();
  DatabaseConnection connection = DatabaseConnection();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    key: UniqueKey(),
                    width: size.width,
                    height: size.height*0.6,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          widget.utilisateurs.photo[0],
                          cacheManager: customCacheManager,
                        ),
                        // image: NetworkImage(widget.utilisateurs.photo[0]),
                        fit: BoxFit.cover
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    margin: EdgeInsets.only(top: size.height*0.57),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${widget.utilisateurs.nom}, ${widget.utilisateurs.age}", style: TextStyle(fontSize: size.width*0.06, fontWeight: FontWeight.bold),),
                                  Text(widget.utilisateurs.profession, style: TextStyle(fontSize: size.width*0.04, color:Colors.grey, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: Icon(CupertinoIcons.heart_fill, color: Theme.of(context).primaryColor, size: 30),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height*0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Localisation", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                                  Text("${widget.utilisateurs.ville}, ${widget.utilisateurs.pays}", style: TextStyle(fontSize: size.width*0.04, color:Colors.grey, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: size.width*0.04,),
                                    Text("1 km", style: TextStyle(fontSize: size.width*0.04, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(4)
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: size.height*0.025),
                          Row(
                            children: [
                              (widget.utilisateurs.sexe == "Femme") ? const Icon(Icons.female) : const Icon(Icons.male),
                              Text(widget.utilisateurs.sexe, style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: size.height*0.025),
                          Text("A propos", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.015),
                          Text(widget.utilisateurs.propos, textAlign: TextAlign.justify, style: TextStyle(fontSize: size.width*0.04),),
                          
                          SizedBox(height: size.height*0.03),
                          Text("Centre d'intérêt", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.02),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: widget.utilisateurs.interet.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: MediaQuery.of(context).size.height * 0.05,
                            crossAxisCount: 3, crossAxisSpacing: 1, mainAxisSpacing: 5), itemBuilder: (context, index) {
                            return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                  child: Text("${widget.utilisateurs.interet[index]}", textAlign: TextAlign.center, style: TextStyle(fontSize: size.width*0.04, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Theme.of(context).primaryColor, width: 1, style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                );
                            },
                          ),
                          // Row(
                          //   children: [
                          //     for(int i=0; i<widget.utilisateurs.interet.length; i++)
                          //       Container(
                          //         margin: EdgeInsets.only(right: 5),
                          //         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          //         child: Text("${widget.utilisateurs.interet[i]}", style: TextStyle(fontSize: size.width*0.04, color: Theme.of(context).primaryColor, fontWeight: FontWeight.w500),),
                          //         decoration: BoxDecoration(
                          //           border: Border.all(color: Theme.of(context).primaryColor, width: 1, style: BorderStyle.solid),
                          //             borderRadius: BorderRadius.circular(4)
                          //         ),
                          //       ),
                          //   ],
                          // ),
                          SizedBox(height: size.height*0.03),
                          Text("Gallerie", style: TextStyle(fontSize: size.width*0.045, fontWeight: FontWeight.bold),),
                          SizedBox(height: size.height*0.02),
                          GridView.builder(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
                                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                              shrinkWrap: true,
                              itemCount: widget.utilisateurs.photo.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        widget.utilisateurs.photo[index],
                                        cacheManager: customCacheManager,
                                      ),
                                      fit: BoxFit.cover
                                    ),
                                    // image: CachedNetworkImageProvider(
                                    //   widget.utilisateurs.photo[0],
                                    //   cacheManager: Utile.customCacheManager,
                                    // ),
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
                                  ),
                                );
                              }
                          )
                        ],
                      ),
                    ),
                  ),
                  
      
                  
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onlike() async {

    Utilisateurs currentUser;
    currentUser = await Utilisateurs.getCurrentUser();
    // sauvegarde du like en ligne
    Likes like = Likes(idSender: currentUser.idutilisateurs, idReceiver: widget.utilisateurs.idutilisateurs);
      likecontroller.findMacth(like, false).then((value){
      // sauvegarde du like en local
      likecontroller.updateLike(widget.utilisateurs.idutilisateurs);
      connection.ajouterLikes(like);    
          // print("resultats du match $value");
      });
  }
  
}




