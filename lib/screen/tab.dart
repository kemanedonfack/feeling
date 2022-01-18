import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:feeling/screen/tab/tinder.dart';
import 'tab/profile.dart';
import 'tab/chat.dart';
import 'tab/home.dart';
import 'tab/location.dart';

class TabScreen extends StatefulWidget {

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  int _currentIndex=0;

  final tabs=  [
    Tinder(),
    LocalisationScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.style),
            label: "",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.heart_fill),
            label: "",
            backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_text_fill),
            label: "",
            backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
            backgroundColor: Colors.green
          )
        ],
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}


