import 'dart:io';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  File? _image;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
               SafeArea (
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Profil",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, settingsRoute);
                      },
                      child: const Icon(Icons.settings)
                    )
                  ],
                ),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                  imagePath(),
                    Positioned(
                      child:InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, editprofilRoute);
                        },
                        child: Container(
                            decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Theme.of(context).primaryColor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, editprofilRoute);
                              },
                              child: const Icon(Icons.edit, color: Colors.white, size: 20)
                            ),
                          )
                        ),
                      ) ,
                      bottom: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.height * 0.035,
                    ),
                 ],
                ),
              ),        
              SizedBox(height: MediaQuery.of(context).size.height * 0.02,), 
              Center(child: Text("Kemane Donfack, 20", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.bold),)),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06,), 
              Text("Description", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
              SizedBox(height: MediaQuery.of(context).size.height * 0.025), 
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        // Text("Gratuit", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontWeight: FontWeight.bold),),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
                        Text("Je suis une étudiante en biochimie à l'Université de douala à la recherche d'une relation sérieuse...", textAlign: TextAlign.center,
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
                        ),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.03), 
                        // MaterialButton(
                        //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(22.0) ),
                        //   color: Theme.of(context).primaryColor,
                        //   onPressed: () {   },
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: Text("Passer premium",
                        //       style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.045, fontWeight: FontWeight.bold),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.04), 
              // Text("Nos abonnement", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, fontWeight: FontWeight.bold),),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02,), 
              // Text("Gratuit : ", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, fontWeight: FontWeight.bold),),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 16,),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.015), 
              //     Text("Swipes illimités", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.w500),),
              //   ],
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 16,),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.015), 
              //     Text("2 Discussions", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.w500),),
              //   ],
              // ),

              // SizedBox(height: MediaQuery.of(context).size.height * 0.025,), 
              // Text("Premium : ", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.045, fontWeight: FontWeight.bold),),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.02), 
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 16,),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.015), 
              //     Text("Swipes illimités", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.w500),),
              //   ],
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 16,),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.015), 
              //     Text("Discussions illimités", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.w500),),
              //   ],
              // ),
              // SizedBox(height: MediaQuery.of(context).size.height * 0.01), 
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.end,
              //   children: [
              //     Icon(Icons.check_circle, color: Theme.of(context).primaryColor, size: 16,),
              //     SizedBox(width: MediaQuery.of(context).size.width * 0.015), 
              //     Text("Favoris illimités", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.043, fontWeight: FontWeight.w500),),
              //   ],
              // ),

             
             ],
          ),
        ),
      ),
    );
  }

  Widget imagePath(){

    if(_image == null){
      return Container(
        margin: const EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 0.2,
        child: const CircleAvatar(
          radius: 100,
          backgroundImage: AssetImage("images/girls/img_14.jpeg"),
        ),
      );
    }else{
      return Container(
        
      );
    }
  }

}
