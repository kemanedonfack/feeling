import 'package:feeling/controllers/like_controller.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/material.dart';
import 'composant/chat_users_list.dart';
import 'models/chat_users.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  List<ChatUsers> chatUsers = [
    ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(text: "Glady's Murphy", secondaryText: "That's Great", image: "images/userImage2.jpeg", time: "Yesterday"),
    ChatUsers(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "images/userImage3.jpeg", time: "31 Mar"),
    ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "images/userImage4.jpeg", time: "28 Mar"),
    ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"),
    ChatUsers(text: "Jane Russel", secondaryText: "Awesome Setup", image: "images/userImage1.jpeg", time: "Now"),
    ChatUsers(text: "Glady's Murphy", secondaryText: "That's Great", image: "images/userImage2.jpeg", time: "Yesterday"),
    ChatUsers(text: "Jorge Henry", secondaryText: "Hey where are you?", image: "images/userImage3.jpeg", time: "31 Mar"),
    ChatUsers(text: "Philip Fox", secondaryText: "Busy! Call me in 20 mins", image: "images/userImage4.jpeg", time: "28 Mar"),
    ChatUsers(text: "Debra Hawkins", secondaryText: "Thankyou, It's awesome", image: "images/userImage5.jpeg", time: "23 Mar"),
    ChatUsers(text: "Jacob Pena", secondaryText: "will update you in evening", image: "images/userImage6.jpeg", time: "17 Mar"),
    ChatUsers(text: "Andrey Jones", secondaryText: "Can you please share the file?", image: "images/userImage7.jpeg", time: "24 Feb"),
    ChatUsers(text: "John Wick", secondaryText: "How are you?", image: "images/userImage8.jpeg", time: "18 Feb"),
  ];

  LikeController likecontroller = LikeController();
  List<Utilisateurs> listmatchs = [];

  @override
  initState(){
    getMatchs();
    super.initState();
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
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for(int i=0; i<listmatchs.length; i++)
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(listmatchs[i].photo[0]),
                            maxRadius: 30,
                          ),
                        ),
                      ],
                    )
                ]
              )
            ),
            const SafeArea (
              child: Padding(
                padding: EdgeInsets.only(left: 16,right: 16, bottom: 10),
                child: Text("Conversations",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const ScrollPhysics(),
              itemBuilder: (context, index){
                return ChatUsersList(
                  text: chatUsers[index].text,
                  secondaryText: chatUsers[index].secondaryText,
                  image: chatUsers[index].image,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void getMatchs() async {
    
    await likecontroller.getMeMatchs().then((value){
      setState(() {
        listmatchs = value;
      });
    });
    print("mes matchs $listmatchs");

  }


}