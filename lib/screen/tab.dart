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
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: "",
            backgroundColor: Colors.blue
          ),
          const BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: "",
            backgroundColor: Colors.red
          ),
          
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(CupertinoIcons.chat_bubble_2_fill),
                if(idusers.isNotEmpty)
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection(C_RELATIONS).doc(idusers).collection(C_MATCHS).where('active', isEqualTo: false).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return const Text('');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("");
                      }
                      if(snapshot.data!.docs.isNotEmpty){
                        return Positioned(
                          top: -1,
                          right: -1.0,
                          child: Stack(
                            children: <Widget>[
                              Icon(
                                Icons.brightness_1,
                                size: 12.0,
                                color: Theme.of(context).primaryColor,
                              ),
                              // Text(snapshot.data!.docs.length.toString())
                            ],
                          )
                        );
                      }else{
                        return const Text("");
                      }                  
                      
                    }
                  )
              ],
            ),
            label: "",
            backgroundColor: Colors.green
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
            backgroundColor: Colors.blue
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


