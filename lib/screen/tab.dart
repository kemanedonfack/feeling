import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/constant/constant.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feeling/screen/tab/tinder.dart';
import 'tab/profile.dart';
import 'tab/chat.dart';
import 'tab/like.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);


  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  int _currentIndex=0;

  final tabs=  [
    const Tinder(),
    const LikeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  String idusers="";

  @override
  initState(){
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel_outlined),
            label: ''
          ),
          if(idusers.isNotEmpty)
            BottomNavigationBarItem(
              icon: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(C_RELATIONS).doc(idusers).collection(C_LIKES).where('read', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.data!.docs.isNotEmpty){
                      return Badge(
                        shape: BadgeShape.circle,
                        position: BadgePosition.topEnd(),
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(CupertinoIcons.suit_heart),
                        badgeContent: Text("${snapshot.data!.docs.length}", style: const TextStyle(color: Colors.white),),
                      );
                    }else{
                      return  const Icon(CupertinoIcons.suit_heart);
                    }
                  }else{
                    return const Text("");
                  }
                  
                }
              ),
            label: ''
            ),

          if(idusers.isNotEmpty)
            BottomNavigationBarItem(
              icon: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(C_RELATIONS).doc(idusers).collection(C_MATCHS).where('active', isEqualTo: false).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    if(snapshot.data!.docs.isNotEmpty){
                      return Badge(
                        shape: BadgeShape.circle,
                        position: BadgePosition.topEnd(),
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(CupertinoIcons.bubble_left_bubble_right),
                        badgeContent: Text("${snapshot.data!.docs.length}", style: const TextStyle(color: Colors.white),),
                      );
                    }else{
                      return  const Icon(CupertinoIcons.bubble_left_bubble_right);
                    }
                  }else{
                    return const Text("");
                  }
                  
                }
              ),
            label: ''
            ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            backgroundColor: Colors.blue,
            label: ''
          ),
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void getUsers() async {

    await Utilisateurs.getUserId().then((value){
      setState(() {
        idusers = value;
      });
    });
  }
  
}


