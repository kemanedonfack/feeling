// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/utile/ripple_animation.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utile/ripple_animation.dart';

class Tinder extends StatefulWidget {
  const Tinder({Key? key}) : super(key: key);

  @override
  _TinderState createState() => _TinderState();
}

class _TinderState extends State<Tinder> {

  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

    List<Utilisateurs> listutilisateurslocal = [
           Utilisateurs(idutilisateurs:"1", nom: "Jane Russel", age: 20, photo: ["https://images.unsplash.com/photo-1530778217282-850ca636e24a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80"], interet: ["Sport", "Jeux Vidéo"], numero: '', pays: '', profession: '', propos: '', sexe: '', ville: '',),
    ];
    DatabaseConnection connection = DatabaseConnection();
    // List<Utilisateurs> listutilisateurs = [];
    // int itemLength = 0;
    
    // double mintaille=120;
    // double maxtaille=170;
    // RangeValues valuestaille = const RangeValues(120, 170);
    // RangeLabels labelstaille = const RangeLabels('120', "200");

    List<Utilisateurs> listutilisateurs = [ ];

  
  UtilisateurController utilisateurcontroller = UtilisateurController();
  LikeController likecontroller = LikeController();

  // variable pour le filtre de recherche
  String sexeRechercher = "Femme";
  List<String> villes = ["Douala", "Yaoundé", "Bamenda", "Buéa", "Ngaoundére", "Garoua", "Maroua"];
  String? ville="Douala";
    
  double minage=18;
  double maxage=35;
  RangeValues valuesage = const RangeValues(18, 35);
  RangeLabels labelsage = const RangeLabels('18', "50");

  bool isloading = true;
  late CarouselSliderController _sliderController;

  @override
  void initState() {
    getUtilisateurs(); 
    super.initState();
    _sliderController = CarouselSliderController();
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
        body: isloading ? const RippleAnimation() :  Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: SwipeCards(
                      matchEngine: _matchEngine,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: [
                            true ? Positioned(
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: true ? Colors.green : Colors.red, width: 2),
                                ),
                                child: Text( true ? 'LIKE' : 'NON',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: MediaQuery.of(context).size.width*0.06,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                transform: true ? Matrix4.rotationZ(-0.2) : Matrix4.rotationZ(0.2),
                              ),
                              top: 25,
                              left: 10,
                            ): Container(
                
                            ),
                            Container(
                              // height: size.height*0.,
                              key: UniqueKey(),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                // color: _swipeItems[index].content.color,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 2
                                  ),
                                ],
                                // image: DecorationImage(
                                //   image: CachedNetworkImageProvider(
                                //     _swipeItems[index].content.photo[0],
                                //     cacheManager: Utile.customCacheManager,
                                //   ),
                                //   // image: NetworkImage(listutilisateurs[index].photo[0]),
                                //     fit: BoxFit.cover
                                // ),
                              ),
                              child: CarouselSlider.builder(
                                unlimitedMode: true,
                                controller: _sliderController,
                                slideTransform: StackTransform(),
                                initialPage: 0,
                                // enableAutoSlider: true,
                                autoSliderDelay: const Duration(seconds: 7),
                                // slideIndicator: SlideIndicato,
                                itemCount: _swipeItems[index].content.photo.length,
                                slideBuilder: (i) {
                                  return CachedNetworkImage(
                                    key: UniqueKey(),
                                    cacheManager: customCacheManager,
                                    fit: BoxFit.cover,
                                    imageUrl: _swipeItems[index].content.photo[i],
                                    placeholder: (context, url){
                                      return const Center(child: CircularProgressIndicator());
                                    },                                    
                                  );
                                }, 
                              ) ,
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
                              height: size.height*0.82,
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
                                          width: size.width * 0.75,
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
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       width: 10,
                                              //       height: 10,
                                              //       decoration: const BoxDecoration(color: Colors.green,shape: BoxShape.circle),
                                              //     ),
                                              //     const SizedBox(
                                              //       width: 10,
                                              //     ),
                                              //     Text("Recently Active", style: TextStyle(color: Colors.white, fontSize: size.width*0.05 ))
                                              //   ],
                                              // ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft, 
                                                child: Wrap(
                                                  direction: Axis.horizontal,
                                                  children: [        
                                                    for(int i=0; i<_swipeItems[index].content.interet.length; i++)
                                                      Padding(
                                                        padding: const EdgeInsets.only(right: 8, top: 4),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            border: listutilisateurslocal[0].interet.contains(_swipeItems[index].content.interet[i]) ? Border.all(color: Colors.white, width: 2) : null,
                                                            borderRadius:BorderRadius.circular(30),
                                                            color: Colors.white.withOpacity(0.2)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
                                                            child: Text(_swipeItems[index].content.interet[i],
                                                            style: TextStyle(color: Colors.white, 
                                                            fontSize: size.width*0.04 )),
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                           width: size.width*0.05,
                                          child: InkWell(
                                            onTap: (){
                                              Navigator.pushNamed(context, profildetailsRoute, arguments: _swipeItems[index].content);
                                            },
                                            child: SizedBox(
                                              child: Center(
                                                child: Icon( Icons.info, color: Colors.white, size: size.width*0.1),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 2, bottom: 0),
                                    width: size.height* 0.8,
                                    padding: const EdgeInsets.symmetric(vertical: 10),
                                    // height: size.height* 0.1,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(1),
                                          Colors.black.withOpacity(0.2),
                                        ],
                                        end: Alignment.topCenter,
                                        begin: Alignment.bottomCenter
                                      ),
                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 20, right: 20, bottom:0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              getUtilisateurs();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.amber),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    // changes position of shadow
                                                  ),
                                                ]
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "images/refresh_icon.svg",                                                
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                               _matchEngine.currentItem?.nope();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.red),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                  ),
                                                ]
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "images/close_icon.svg",                                                
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              //  Navigator.pushNamed(context, matchRoute, arguments: _swipeItems[index].content);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.blue),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                  ),
                                                ]
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "images/star_icon.svg",                                                
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              onlike(_swipeItems[index].content);
                                              // _sliderController.previousPage();
                                               _matchEngine.currentItem?.like();
                                               
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.greenAccent),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                  ),
                                                ]
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "images/like_icon.svg",                                                
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              // matchs(context, listutilisateurs[index]);
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(color: Colors.purple),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.withOpacity(0.1),
                                                    spreadRadius: 5,
                                                    blurRadius: 10,
                                                    // changes position of shadow
                                                  ),
                                                ]
                                              ),
                                              child: Center(
                                                child: SvgPicture.asset(
                                                  "images/thunder_icon.svg",                                                
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                               ),
                            ),
                            
                
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
    
    await connection.getUtilisateurs().then((value){
      setState(() {
        listutilisateurslocal = value;
          if (kDebugMode) {
            print("nom utilisateur courant ${listutilisateurslocal[0].sexe}");
          }
      });
    });

    await utilisateurcontroller.getAllUsers(listutilisateurslocal[0].sexe).then((value) async {
      setState(() {
        listutilisateurs =  value;

        if (kDebugMode) {
          print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
        }
          _swipeItems.clear();
          _swipeItemsMapsUser();
      });
    
    });

    
      
  }

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

    setState(() {
      isloading = true;
    });

    await utilisateurcontroller.getFiltersUsers(sexeRechercher, minage, maxage, ville as String).then((value){
      setState(() {
        listutilisateurs =  value;

        if(listutilisateurs.isNotEmpty){
          _swipeItems.clear();
          if (kDebugMode) {
            print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
          }
          _swipeItemsMapsUser();
        }else{
          getUtilisateurs();
        }
      });
    });

  }

  void _swipeItemsMapsUser(){

      for (int i = 0; i < listutilisateurs.length; i++) {
        _swipeItems.add(SwipeItem(
          content: Utilisateurs(idutilisateurs: listutilisateurs[i].idutilisateurs, age: listutilisateurs[i].age, 
            interet: listutilisateurs[i].interet, nom: listutilisateurs[i].nom.capitalize(), numero: listutilisateurs[i].numero, 
            pays: listutilisateurs[i].pays, photo: listutilisateurs[i].photo, profession: listutilisateurs[i].profession,
            propos: listutilisateurs[i].propos, sexe: listutilisateurs[i].sexe, ville: listutilisateurs[i].ville),
            
            likeAction: () async {

              onlike(listutilisateurs[i]);

                Fluttertoast.showToast(
                    msg: "J'aime bien ${listutilisateurs[i].nom}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },

              nopeAction: () {
                Fluttertoast.showToast(
                    msg: "J'aime pas ${listutilisateurs[i].nom}",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              },

              superlikeAction: () {
                _scaffoldKey.currentState?.showSnackBar(SnackBar(
                  content: Text("Superliked ${listutilisateurs[i].nom}"),
                  duration: const Duration(milliseconds: 500),
                ));
              },
        )
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    setState(() {
      isloading=false;
    });

  }

  Future<void> matchs(context, Utilisateurs utilisateurs) async {
    var size = MediaQuery.of(context).size;
     return showDialog(
       context: context,
       barrierDismissible: true,
       builder: (BuildContext context){
         return  Center(
           child: Container(
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(20),
               color: Colors.white,
               boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 5,
                  spreadRadius: 2
                ),
              ],
             ),
              width: size.width*0.9,
              height: size.height*0.85,
             child: Column(
               children: [
                 SizedBox(
                   height: size.height*0.02,
                 ),
                 Text("Félicitations", style: TextStyle(fontSize: size.width*0.1, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                 RichText(
                   text: TextSpan(
                     text: "C'est un ",
                     style: TextStyle(fontSize: size.width*0.07, color: Colors.black, fontWeight: FontWeight.bold),
                     children: <TextSpan>[
                       TextSpan(
                           text: "macth!",
                           style: TextStyle(fontWeight: FontWeight.bold,  fontSize: size.width*0.07, color: Colors.white, backgroundColor: Theme.of(context).primaryColor)),
                     ],
                   ),
                 ),
                 SizedBox(
                   height: size.height*0.02,
                 ),
                 
                 CircleAvatar(
                   backgroundImage: NetworkImage(utilisateurs.photo[0]),
                   maxRadius: 100,
                 ),
                 SizedBox(
                   height: size.height*0.02,
                 ),
                 RichText(
                   text: TextSpan(
                     text: "${utilisateurs.nom.capitalize()}, ",
                     style: TextStyle(fontSize: size.width*0.06, color: Colors.black, fontWeight: FontWeight.bold),
                     children: <TextSpan>[
                       TextSpan(
                           text: utilisateurs.age.toString(),
                           style: TextStyle(fontWeight: FontWeight.w500,  fontSize: size.width*0.06, color: Colors.black,),
                       )
                     ],
                   ),
                 ),
                 SizedBox(
                   height: size.height*0.04,
                 ),
                 Material(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Theme.of(context).primaryColor ,
                   child: MaterialButton(
                     minWidth: MediaQuery.of(context).size.width*0.8,
                     onPressed: () {  },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Envoyé un message",
                         style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: size.height*0.02,
                 ),
                 Material(
                   borderRadius: BorderRadius.circular(10.0),
                   color: Theme.of(context).primaryColor ,
                   child: MaterialButton(
                     minWidth: MediaQuery.of(context).size.width*0.8,
                     onPressed: () { Navigator.of(context).pop(); },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Text("Plus tard",
                         style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                       ),
                     ),
                   ),
                 ),
                 // Text("Kemane vous amie bien", style: TextStyle(fontSize: size.width*0.05, color: Colors.white), textAlign: TextAlign.center,),
               ],
             ),
           ),
         );
       }
     );
  }

  void onlike(Utilisateurs utilisateur) {

    // sauvegarde du like en ligne
    Likes like = Likes(idSender: listutilisateurslocal[0].idutilisateurs, idReceiver: utilisateur.idutilisateurs);
      likecontroller.findMacth(like).then((value){
      // sauvegarde du like en local
      connection.ajouterLikes(like);    
        if(value) matchs(context, utilisateur);
          // print("resultats du match $value");
      });
  }

      

}

