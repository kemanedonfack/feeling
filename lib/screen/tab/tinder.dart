// ignore_for_file: deprecated_member_use

import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:swipe_cards/swipe_cards.dart';

class Tinder extends StatefulWidget {
  const Tinder({Key? key}) : super(key: key);



  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  
    // List<Utilisateurs> listutilisateurs = [];
    // int itemLength = 0;
    
    // double mintaille=120;
    // double maxtaille=170;
    // RangeValues valuestaille = const RangeValues(120, 170);
    // RangeLabels labelstaille = const RangeLabels('120', "200");

    List<Utilisateurs> listutilisateurs = [
     Utilisateurs(idutilisateurs:"1", nom: "Jane Russel", age: 20, photo: ["https://images.unsplash.com/photo-1530778217282-850ca636e24a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"], interet: ["Sport", "Jeux Vidéo"], numero: '', pays: '', profession: '', propos: '', sexe: '', ville: '',),
  ];

  
  UtilisateurController utilisateurcontroller = UtilisateurController();

  // variable pour le filtre de recherche
  String sexeRechercher = "Femme";
  List<String> villes = ["Douala", "Yaoundé", "Bamenda", "Buéa", "Ngaoundére", "Garoua", "Maroua"];
  String? ville="Douala";
    
  double minage=18;
  double maxage=35;
  RangeValues valuesage = const RangeValues(18, 35);
  RangeLabels labelsage = const RangeLabels('18', "50");

  @override
  void initState() {
    getUtilisateurs(); 
  
    for (int i = 0; i < listutilisateurs.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Utilisateurs(idutilisateurs: listutilisateurs[i].idutilisateurs, age: listutilisateurs[i].age, 
            interet: listutilisateurs[i].interet, nom: listutilisateurs[i].nom, numero: listutilisateurs[i].numero, 
            pays: listutilisateurs[i].pays, photo: listutilisateurs[i].photo, profession: listutilisateurs[i].profession,
            propos: listutilisateurs[i].propos, sexe: listutilisateurs[i].sexe, ville: listutilisateurs[i].ville),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${listutilisateurs[i].nom}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${listutilisateurs[i].nom}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          superlikeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Superliked ${listutilisateurs[i].nom}"),
              duration: const Duration(milliseconds: 500),
            ));
          },
          // onSlideUpdate: (SlideRegion region) async {
          //   print("Region $region");
          // }
        )
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("Découvrir"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: (){
              showModal();
            },
            child: Padding(
             padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Icon(Icons.tune_sharp, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.08),
            ),
          ),
        ],
      ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: SwipeCards(
                    matchEngine: _matchEngine,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        children: [
                          Container(
                            key: UniqueKey(),
                            decoration: BoxDecoration(
                              // color: _swipeItems[index].content.color,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 2
                                ),
                              ],
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  _swipeItems[index].content.photo[0],
                                  cacheManager: Utile.customCacheManager,
                                ),
                                // image: NetworkImage(listutilisateurs[index].photo[0]),
                                  fit: BoxFit.cover
                              ),
                            ),
                            // child: CachedNetworkImage(
                            //   key: UniqueKey(),
                            //   fit: BoxFit.cover,
                            //   cacheManager: customCacheManager,
                            //   imageUrl: listutilisateurs[index].photo[0],
                            //   placeholder: (context, url){
                            //     return const Center(child: CircularProgressIndicator());
                            //   },
                            // ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     ElevatedButton(
                          //         onPressed: () {
                          //           _matchEngine.currentItem?.nope();
                          //         },
                          //         child: Text("Nope")),
                          //     ElevatedButton(
                          //         onPressed: () {
                          //           _matchEngine.currentItem?.superLike();
                          //         },
                          //         child: Text("Superlike")),
                          //     ElevatedButton(
                          //         onPressed: () {
                          //           _matchEngine.currentItem?.like();
                          //         },
                          //         child: Text("Like"))
                          //   ],
                          // ),
                          Container(
                            width: size.width,
                            height: size.height*0.7,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.black.withOpacity(0.25),
                                  Colors.black.withOpacity(0),
                                ],
                                end: Alignment.topCenter,
                                begin: Alignment.bottomCenter
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: size.width * 0.72,
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text("${_swipeItems[index].content.nom}, ",style: TextStyle(color: Colors.white, fontSize: size.width*0.06, fontWeight: FontWeight.bold),),
                                                Text("${_swipeItems[index].content.age}", style: TextStyle(color: Colors.white, fontSize: size.width*0.06),),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: const BoxDecoration(color: Colors.green,shape: BoxShape.circle),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text("Recently Active", style: TextStyle(color: Colors.white, fontSize: size.width*0.05 ))
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            Row(
                                              children: [        
                                                for(int i=0; i<_swipeItems[index].content.interet.length && i<3 ; i++)
                                                  Flexible(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.white, width: 2),
                                                          borderRadius:BorderRadius.circular(30),
                                                          color:Colors.white.withOpacity(0.4)
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
                                                          child: Text(_swipeItems[index].content.interet[i],style: TextStyle(color: Colors.white, fontSize: size.width*0.04 )),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Flexible(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.pushNamed(context, profildetailsRoute, arguments: listutilisateurs[index]);
                                          },
                                          child: SizedBox(
                                            width: size.width * 0.2,
                                            child: Center(
                                              child: Icon( Icons.info, color: Colors.white, size: size.width*0.12),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                             ),
                          )

                        ],
                      );
                    },
                    onStackFinished: () {
                      _scaffoldKey.currentState!.showSnackBar(const SnackBar(
                        content: Text("Stack Finished"),
                        duration: Duration(milliseconds: 500),
                      ));
                      getUtilisateurs();
                    },
                    itemChanged: (SwipeItem item, int index) {
                      if (kDebugMode) {
                        print("item: item, index: $index");
                      }
                    },
                    upSwipeAllowed: true,
                    fillSpace: true,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 2, bottom: 0),
                  width: size.height* 0.8,
                  height: size.height* 0.1,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom:0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 10,
                              ),
                            ]
                          ),
                          child: const Center(
                            child: Icon(Icons.refresh, color: Colors.amber,),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, matchRoute);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 10,
                                  blurRadius: 10,
                                ),
                              ]
                            ),
                            child: const Center(
                              child: Icon(Icons.message, color: Colors.blue, size: 27,),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 10,
                                blurRadius: 10,
                              ),
                            ]
                          ),
                          child: const Center(
                            child: Icon(Icons.favorite, color: Colors.redAccent),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
      )
    );
  }

  void showModal(){

    var size = MediaQuery.of(context).size;
    
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext c){
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState ){
            return Container(
              height: size.height*0.75,
            color: const Color(0xff737373),
            child: Container(
              padding: const EdgeInsets.only(bottom: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        height: 4,
                        width: 50,
                        color: Colors.grey.shade200,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close, color: Theme.of(context).primaryColor)
                          ),
                          Text("Filtres", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06),),
                          const Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width*0.05),
                    Text("intéréssé par", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                    const SizedBox(height: 10,),
                    Container(
                      width: size.width*0.89,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectSexe("Homme");
                              });
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                color: sexeRechercher.contains("Homme") ? Theme.of(context).primaryColor : Colors.white,
                                width: size.width*0.44,
                                child: Center(child: Text("Homme", style: TextStyle(color: sexeRechercher.contains("Homme") ? Colors.white : Colors.black ),)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectSexe("Femme");
                              });
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Container(
                                color: sexeRechercher.contains("Femme") ? Theme.of(context).primaryColor : Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                width: size.width*0.44,
                                child: Center(child: Text("Femme", style: TextStyle(color: sexeRechercher.contains("Femme") ? Colors.white : Colors.black ),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width*0.05),
                    Text("Localisation", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                    SizedBox(height: size.width*0.06,),
                    Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey.withOpacity(0.3),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: DropdownButton(
                        isExpanded: true,
                        hint: Text(ville!) ,
                        underline: const SizedBox(),
                        items: villes.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState((){
                            ville = value as String?; 
                          });
                        },
                      ),
                    )
                  ),                    
                    SizedBox(height: size.width*0.06,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Age", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                        Text("$minage - $maxage ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),)
                      ],
                    ),
                    RangeSlider(
                      divisions: 32,
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Theme.of(context).primaryColor.withOpacity(0.5),
                      min: 18,
                      max: 50,
                      values: valuesage,
                      onChanged: (value){
                        if (kDebugMode) {
                          print("START: ${value.start}, End: ${value.end}");
                        }
                        setState(() {
                            valuesage =value;
                            minage = value.start;
                            maxage = value.end;
                            labelsage = RangeLabels("${value.start.toInt().toString()}\$", "${value.start.toInt().toString()}\$");
                        });
                      }
                    ),
                    SizedBox(height: size.width*0.05),
                    // Text("Corpulence", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                    // const SizedBox(height: 10,),
                    // Container(
                    //   width: size.width*0.89,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid)
                    //   ),
                    //   child: Row(
                    //     children: [
                    //       ClipRRect(
                    //         borderRadius: const BorderRadius.only(
                    //           bottomLeft: Radius.circular(10),
                    //           topLeft: Radius.circular(10),
                    //         ),
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                    //           color: Theme.of(context).primaryColor,
                    //           width: size.width*0.28,
                    //           child: const Center(child: Text("Ronde", style: TextStyle(color: Colors.white),)),
                    //         ),
                    //       ),
                    //       Container(
                    //         padding: const EdgeInsets.symmetric(vertical: 12),
                    //         // color: Theme.of(context).primaryColor,
                    //         width: size.width*0.3,
                    //         child: const Center(child: Text("Moyenne", style: TextStyle(color: Colors.black),)),
                    //       ),
                    //       ClipRRect(
                    //         borderRadius: const BorderRadius.only(
                    //           bottomRight: Radius.circular(10),
                    //           topRight: Radius.circular(10),
                    //         ),
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(vertical: 12),
                    //           width: size.width*0.3,
                    //           color: Theme.of(context).primaryColor,
                    //           child: const Flexible(child: Center(child: Text("Manéquaine", style: TextStyle(color: Colors.white),))),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(height: size.width*0.1),
                    Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: size.width,
                      onPressed: () {  filtre(); Navigator.pop(context); },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("Appliquer",
                          style: TextStyle(color: Colors.white, fontSize: size.width*0.05, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  
                  ],
                ),
              ),
            ),
          );
          },
          
        );
      }
    );
  }

  void getUtilisateurs() async {
    await utilisateurcontroller.getAllUsers().then((value){
      setState(() {
        listutilisateurs =  value;

        if (kDebugMode) {
          print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
        }
          _swipeItems.clear();
        for (int i = 0; i < listutilisateurs.length; i++) {
          _swipeItems.add(SwipeItem(
              content: Utilisateurs(idutilisateurs: listutilisateurs[i].idutilisateurs, age: listutilisateurs[i].age, 
                interet: listutilisateurs[i].interet, nom: listutilisateurs[i].nom, numero: listutilisateurs[i].numero, 
                pays: listutilisateurs[i].pays, photo: listutilisateurs[i].photo, profession: listutilisateurs[i].profession,
                propos: listutilisateurs[i].propos, sexe: listutilisateurs[i].sexe, ville: listutilisateurs[i].ville),
              likeAction: () {
                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text("Liked ${listutilisateurs[i].nom}"),
                  duration: const Duration(milliseconds: 500),
                ));
              },
              nopeAction: () {
                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text("Nope ${listutilisateurs[i].nom}"),
                  duration: const Duration(milliseconds: 500),
                ));
              },
              superlikeAction: () {
                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text("Superliked ${listutilisateurs[i].nom}"),
                  duration: const Duration(milliseconds: 500),
                ));
              },
              // onSlideUpdate: (SlideRegion region) async {
              //   print("Region $region");
              // }
            )
          );
        }
        
        _matchEngine = MatchEngine(swipeItems: _swipeItems);

        // taille du carousel
        // itemLength = listutilisateurs.length;
      });
    });
  }

  int getImage(int taille){

    Random rand = Random();
    int re = rand.nextInt(taille);

    return re;
  }

  // void clearCache(){
  //   DefaultCacheManager().emptyCache();

  //   imageCache!.clear();
  //   imageCache!.clearLiveImages();
  //   setState(() {
      
  //   });
  // }

  void selectSexe(String sexe) {
    if(!sexeRechercher.contains(sexe)){
      setState(() {
        sexeRechercher=sexe;
      });
    }else{
      setState(() {
        sexeRechercher=sexe;
      });
    }
  }

  void filtre() async {

    await utilisateurcontroller.getFiltersUsers(sexeRechercher, minage, maxage, ville as String).then((value){
      setState(() {
        listutilisateurs =  value;

        if(listutilisateurs.isNotEmpty){
          if (kDebugMode) {
            print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
          }
          _swipeItems.clear();
          for (int i = 0; i < listutilisateurs.length; i++) {
            _swipeItems.add(SwipeItem(
                content: Utilisateurs(idutilisateurs: listutilisateurs[i].idutilisateurs, age: listutilisateurs[i].age, 
                  interet: listutilisateurs[i].interet, nom: listutilisateurs[i].nom, numero: listutilisateurs[i].numero, 
                  pays: listutilisateurs[i].pays, photo: listutilisateurs[i].photo, profession: listutilisateurs[i].profession,
                  propos: listutilisateurs[i].propos, sexe: listutilisateurs[i].sexe, ville: listutilisateurs[i].ville),
                likeAction: () {
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(
                    content: Text("Liked ${listutilisateurs[i].nom}"),
                    duration: const Duration(milliseconds: 500),
                  ));
                },
                nopeAction: () {
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(
                    content: Text("Nope ${listutilisateurs[i].nom}"),
                    duration: const Duration(milliseconds: 500),
                  ));
                },
                superlikeAction: () {
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(
                    content: Text("Superliked ${listutilisateurs[i].nom}"),
                    duration: const Duration(milliseconds: 500),
                  ));
                },
                // onSlideUpdate: (SlideRegion region) async {
                //   print("Region $region");
                // }
              )
            );
          }
        _matchEngine = MatchEngine(swipeItems: _swipeItems);
        }else{
          getUtilisateurs();
        }

        // taille du carousel
        // itemLength = listutilisateurs.length;
      });
    });

  }

}