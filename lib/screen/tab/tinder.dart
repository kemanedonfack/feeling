// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/controllers/notification_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/models/filtres.dart';
import 'package:feeling/models/like.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:feeling/localization/language_constants.dart';
import 'package:feeling/utile/custom_dialog_box.dart';
import 'package:feeling/utile/ripple_animation.dart';
import 'package:feeling/utile/utile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  late Utilisateurs currentUser;
  DatabaseConnection connection = DatabaseConnection();
    

  List<Utilisateurs> listutilisateurs = [ ];

  
  UtilisateurController utilisateurcontroller = UtilisateurController();
  LikeController likecontroller = LikeController();
  NotificationController notificationController = NotificationController();

  // variable pour le filtre de recherche    
  RangeValues valuesage = const RangeValues(18, 35);
  RangeLabels labelsage = const RangeLabels('18', "50");

  bool isloading = true;
  late CarouselSliderController _sliderController;
  Filtres filtres = Filtres(minAge: 18, maxAge: 23, sexe: 'sexe', pays: 'pays', ville: 'ville', showDislike: false);
  int booster=0, superLike=0;
  int referralCode=0;

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
        title: Text(getTranslated(context,'decouvrir')),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Flexible(
            child: Row(
              children: [
                Text("25", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.05,)),
                SvgPicture.asset(
                  "images/like_icon.svg",                                                
                )
              ],
            ),
          ),
        ),
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
        body: isloading ? const RippleAnimation() : 
          listutilisateurs.isEmpty ? Padding(
            padding: const EdgeInsets.all(8.0),
            child:  Center(child: Text(getTranslated(context,'aucun_utilisateur'), textAlign: TextAlign.center,)),
          ) :  Container(
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
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  );
                                }, 
                              ) ,
                            ),
                            
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
                                                            border: currentUser.interet.contains(_swipeItems[index].content.interet[i]) ? Border.all(color: Colors.white, width: 2) : null,
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
                                        SizedBox(
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
                                               _matchEngine.currentItem?.nope();
                                               ondislike(_swipeItems[index].content);
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
                                              if(superLike>0){
                                                if (kDebugMode) {
                                                  print("super Like en cours $superLike");
                                                }
                                                _matchEngine.currentItem?.superLike();
                                                onsuperlike(_swipeItems[index].content);
                                                setSuperLike();
                                              }else{
                                                showDialog(context: context,
                                                  builder: (BuildContext context){
                                                    return CustomDialogBox(
                                                      title: getTranslated(context,'infos'),
                                                      descriptions: getTranslated(context,'aucun_like'),
                                                      text: "ok",
                                                      svg_icon: "images/star_icon.svg",
                                                    );
                                                  }
                                                );
                                              }
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
                                              if(booster>0){
                                                setBooster(context);
                                              }else{
                                                showDialog(context: context,
                                                  builder: (BuildContext context){
                                                    return CustomDialogBox(
                                                      title: getTranslated(context,'infos'),
                                                      descriptions: getTranslated(context,'aucun_booster'),
                                                      text: "ok",
                                                      svg_icon: "images/thunder_icon.svg",
                                                    );
                                                  }
                                                );
                                              }
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
                        // _scaffoldKey.currentState!.showSnackBar(const SnackBar(
                        //   content: Text("Stack Finished"),
                        //   duration: Duration(milliseconds: 500),
                        // ));
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
              height: size.height*0.85,
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
                          Text(getTranslated(context,'filtre'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.06),),
                          const Text(" "),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width*0.05),
                    Text(getTranslated(context,'interesse_par'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
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
                                selectSexe('Homme');
                              });
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                color: filtres.sexe.contains('Homme') ? Theme.of(context).primaryColor : Colors.white,
                                width: size.width*0.44,
                                child: Center(child: Text(getTranslated(context,'homme'), style: TextStyle(color: filtres.sexe.contains('Homme') ? Colors.white : Colors.black ),)),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                selectSexe('Femme');
                              });
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              child: Container(
                                color: filtres.sexe.contains('Femme') ? Theme.of(context).primaryColor : Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                width: size.width*0.44,
                                child: Center(child: Text(getTranslated(context,'femme'), style: TextStyle(color: filtres.sexe.contains('Femme') ? Colors.white : Colors.black ),)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: size.width*0.05),
                    Text(getTranslated(context,'localisation'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                    SizedBox(height: size.width*0.06,),
                    CSCPicker(
                      
                      showStates: true,
                      showCities: true,
                      flagState: CountryFlag.DISABLE,

                      ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                      dropdownDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300, width: 1)
                      ),

                      disabledDropdownDecoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border:  Border.all(color: Colors.grey.shade300, width: 1)
                      ),

                      countrySearchPlaceholder: getTranslated(context, 'pays'),
                      stateSearchPlaceholder: getTranslated(context, 'region'),
                      citySearchPlaceholder: getTranslated(context, 'ville'),

                      countryDropdownLabel: getTranslated(context, 'pays'),
                      stateDropdownLabel: getTranslated(context, 'region'),
                      cityDropdownLabel: getTranslated(context, 'ville'),

                      defaultCountry: DefaultCountry.Cameroon,

                      selectedItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      dropdownHeadingStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),

                      dropdownItemStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),

                      dropdownDialogRadius: 10.0,

                      searchBarRadius: 10.0,

                      onCountryChanged: (value) {
                        setState(() {
                          filtres.pays = value;
                        });
                      },

                      onStateChanged: (value) {
                        if(value != null){
                          setState(() {
                            // state.text = value;
                          });
                        }
                      },

                      onCityChanged: (value) {
                        if(value != null){
                          setState(() {
                            filtres.ville = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: size.width*0.04),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(getTranslated(context,'select_age'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                        Text("${filtres.minAge} - ${filtres.maxAge} ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),)
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
                        setState(() {
                            valuesage =value;
                            filtres.minAge = value.start.ceil();
                            filtres.maxAge= value.end.ceil();
                            labelsage = RangeLabels("${value.start.toInt().toString()}\$", "${value.start.toInt().toString()}\$");
                        });
                      }
                    ),
                    // SizedBox(height: size.width*0.02),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(getTranslated(context,'profil_rejete'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: size.width*0.045),),
                        Switch(
                          activeColor: Theme.of(context).primaryColor,
                          value: filtres.showDislike, 
                          onChanged: (bool value) { 
                            setState((){
                              filtres.showDislike = value;
                            });                        
                          }, 
                        ),
                      ],
                    ),
                    SizedBox(height: size.width*0.01),
                    
                    
                    Material(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: size.width,
                      onPressed: () {  filtre(); Navigator.pop(context); },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(getTranslated(context,'btn_appliquer'),
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
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    currentUser = await Utilisateurs.getCurrentUser();
    setState(() {
      referralCode = _prefs.getInt("referralCode")!;
    });
    // print("donne utilisateurs courant ${currentUser.ville} ${currentUser.pays}");
    // print("je veux ${currentUser.age+5} ${currentUser.pays} ${currentUser.ville} ${currentUser.age+5}");
    if(currentUser.sexe == "Homme"){
      filtres.sexe=getTranslated(context,'femme');
    }else{
      filtres.sexe ="Homme";
    }
    filtres.minAge = 18;
    filtres.maxAge = currentUser.age+5;
    filtres.pays = currentUser.pays;
    filtres.ville = currentUser.ville;

    await utilisateurcontroller.getAllUsers(filtres).then((value) async {
      setState(() {
        // print("j'ai récupérer ${value.length} utilisateurs");
        listutilisateurs =  value;

        if(listutilisateurs.isNotEmpty){
          if (kDebugMode) {
            print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
          }
          _swipeItems.clear();
          _swipeItemsMapsUser();
        }else{
          if (kDebugMode) {
            print("aucune donnée");
          }
          setState(() {
            isloading=false;
          });
        }
      });
    
    });

    await utilisateurcontroller.getGains(currentUser.idutilisateurs).then((value){
      Map gains = {};
      setState(() {
        gains = value.data() as Map;
        // print("gains de l'utilisateurs courant ^$gains");
        _prefs.setInt("booster", gains['booster']);
        _prefs.setInt("superLike", gains['superLike']);
        booster = gains['booster'];
        superLike = gains['superLike'];
      });
    });

  }

  void selectSexe(String sexe) {
    if(!filtres.sexe.contains(sexe)){
      setState(() {
        filtres.sexe=sexe;
      });
    }else{
      setState(() {
        filtres.sexe=sexe;
      });
    }
  }

  void filtre() async {

    setState(() {
      isloading = true;
    });

    await utilisateurcontroller.getAllUsers(filtres).then((value) async {
      setState(() {
        listutilisateurs =  value;

        if(listutilisateurs.isNotEmpty){
          if (kDebugMode) {
            print("taille ${listutilisateurs.length} id ${listutilisateurs[0].photo[0]} ");
          }
          _swipeItems.clear();
          _swipeItemsMapsUser();
        }else{
          if (kDebugMode) {
            print("aucune donnée");
          }
          setState(() {
            isloading=false;
          });
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
            propos: listutilisateurs[i].propos, sexe: listutilisateurs[i].sexe, ville: listutilisateurs[i].ville, online: listutilisateurs[i].online, 
            email: listutilisateurs[i].email, etablissement: listutilisateurs[i].etablissement, 
            token: listutilisateurs[i].token,),
            
            likeAction: () async {
              onlike(listutilisateurs[i]);
            },

            nopeAction: () {
              ondislike(listutilisateurs[i]);
            },

            superlikeAction: () {
              onlike(listutilisateurs[i]);
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
                 Text(getTranslated(context, 'felicitation'), style: TextStyle(fontSize: size.width*0.1, color: Colors.black, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                 RichText(
                   text: TextSpan(
                     text: getTranslated(context, 'macth'),
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
                       child: Text(getTranslated(context, 'envoye_message'),
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
                       child: Text(getTranslated(context, 'plus_tard'),
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

  void onsuperlike(Utilisateurs utilisateur) {

    // sauvegarde du like en ligne
    Likes superlike = Likes(idSender: currentUser.idutilisateurs, idReceiver: utilisateur.idutilisateurs);
    // likecontroller.saveSuperLike(superlike);
    likecontroller.findMacth(superlike, true).then((value){
      // sauvegarde du like en local
      connection.ajouterLikes(superlike);   
      if(value == true){
          matchs(context, utilisateur);
          notificationController.sendPushNotification("Feeling", "${getTranslated(context, 'nouveau_match')} Match", utilisateur.token);
        }else{
          notificationController.sendPushNotification("Feeling", "${currentUser.nom} ${getTranslated(context, 'nouveau_super_like')} SuperLike", utilisateur.token);
        }  
          // print("resultats du match $value");
    });
  }
  
  void onlike(Utilisateurs utilisateur) async {

    // sauvegarde du like en ligne
    Likes like = Likes(idSender: currentUser.idutilisateurs, idReceiver: utilisateur.idutilisateurs);
      await likecontroller.findMacth(like, false).then((value){
        // sauvegarde du like en local
        connection.ajouterLikes(like);  
        if(value == true){
          matchs(context, utilisateur);
            notificationController.sendPushNotification("Feeling", "${getTranslated(context, 'nouveau_match')} Match", utilisateur.token);
        }else{
          notificationController.sendPushNotification("Feeling", "${currentUser.nom} ${getTranslated(context, 'like')}", utilisateur.token);
        }  
      });
  }

  void ondislike(Utilisateurs utilisateur) {

    // sauvegarde du like en ligne
    Likes dislike = Likes(idSender: currentUser.idutilisateurs, idReceiver: utilisateur.idutilisateurs);
    connection.ajouterDisLikes(dislike);    
  }
  

  void setSuperLike() async{

    superLike = superLike-1;
    utilisateurcontroller.superLike(currentUser.idutilisateurs);
    
  }
  
  void setBooster(BuildContext contect) async{

    booster = booster-1;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setBool("isBooster", true);
    var now =  DateTime.now(); 
    // print("date de debut ${ (now.millisecondsSinceEpoch.toString())}");
    var t = now.add(const Duration(days: 2));
    // print("date de fin ${ t.millisecondsSinceEpoch.toString()}");

    _prefs.setInt('dateToEndBooster', t.millisecondsSinceEpoch);
    utilisateurcontroller.booster(currentUser.idutilisateurs);
    showDialog(context: context,
      builder: (BuildContext context){
        return CustomDialogBox(
          title: getTranslated(context,'infos'),
          descriptions: getTranslated(context,'profil_booster'),
          text: "ok",
          svg_icon: "images/thunder_icon.svg",
        );
      }
    );
  }

  Future<void> testConnection(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'erreur_internet')),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: const Text("OK"),
              )
            ],
          );
        }
    );
  }

}

