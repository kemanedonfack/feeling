import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';


class PhotoEscort extends StatefulWidget {

  final Utilisateurs utilisateurs;
  PhotoEscort(this.utilisateurs);


  @override
  _PhotoEscortState createState() => _PhotoEscortState();
}

class _PhotoEscortState extends State<PhotoEscort> {

  late File _image;
  // final picker = ImagePicker();

  // @override
  // initState(){
  //   print("service ${widget.utilisateurs.services}");
  // }

  @override
  Widget build(BuildContext context) {
    
  var size = MediaQuery.of(context).size;

      return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Photo escort", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor)
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*0.02),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      showModal();
                    },
                    child: imagePath()
                  ),
                  // InkWell(
                  //   onTap: (){
                  //     showModal(_image2);
                  //   },
                  //   child: imagePath(_image2)
                  // ),InkWell(
                  //   onTap: (){
                  //     showModal(_image3);
                  //   },
                  //   child: imagePath(_image3)
                  // ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.03),
              Material(
                borderRadius: BorderRadius.circular(10.0),
                color: Theme.of(context).primaryColor ,
                child: MaterialButton(
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () { Navigator.pushNamed(context, tabRoute); },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Ajouter Photo",
                      style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  
  Widget imagePath(){

    if(_image == null){
      return Container(
        margin: const EdgeInsets.only(right: 5),
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.3,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 12,
              child: Icon(Icons.add_a_photo, size: 18, color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      );
    }else{
      return Container(
        margin: const EdgeInsets.only(right: 5),
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.3,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: FileImage(_image),
            fit: BoxFit.cover
          ),
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              radius: 12,
              child: Icon(Icons.close, size: 18, color: Theme.of(context).primaryColor),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      );
    }
  }

  
//  void getImage(ImageSource source) async {
//     var pickedFile = await picker.pickImage(source: source);
//     setState(() {
//       if(pickedFile != null){
//         _image = File(pickedFile.path);
//       }
//     });
//   }

  void showModal(){

    var size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext c){
        return Container(
          height: size.height*0.3,
          color: const Color(0xff737373),
         child: Container( 
           
           decoration: const BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: const EdgeInsets.only(top: 10, left: 15, right: 10, bottom: 20),
                 child: Text("Choisir une photo", style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),),
               ),
               ListTile(
                 onTap: (){
                  // getImage(ImageSource.camera);
                 },
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor,
                    ),
                    height: 50,
                    width: 50,
                    child: Icon(Icons.camera_alt, color: Colors.white,),
                  ),
                  title: Text("Caméra"),
                ),
                ListTile(
                  onTap: (){
                  // getImage(ImageSource.gallery);
                 },
                  leading: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Theme.of(context).primaryColor,
                    ),
                    height: 50,
                    width: 50,
                    child: Icon(Icons.image, color: Colors.white,),
                  ),
                  title: Text("Galerie"),
                ),
              ],           
           ),
         ),
        );
      }
    );
  }



}

