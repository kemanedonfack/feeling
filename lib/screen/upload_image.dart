import 'dart:io';
import 'package:feeling/utile/connection.dart';
import 'package:feeling/db/db.dart';
import 'package:path/path.dart' as p;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:path_provider/path_provider.dart';

class UploadImageScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  UploadImageScreen(this.utilisateurs);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  
  final ImagePicker picker = ImagePicker();
  List<XFile> selectedFile = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];
  List<String> localImageUrls = [];
  
  late GlobalKey<ScaffoldState> globalKey;
  // List<String> imageUrls = <String>[];
  bool loading = false;
  
  // List<Asset> images = <Asset>[];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey, width: 1, style: BorderStyle.solid),
                    ),
                    child: Padding(
                     padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                      child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor, size: MediaQuery.of(context).size.width*0.06),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                Text("Importer Photos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.05)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                InkWell(
                  onTap: (){
                    print("oui");
                    setState(() {
                      selectedFile = [];
                    });
                  },
                  child: Row(
                    children: [
                      Text("Choisissez 3 photos.", style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.width*0.04)
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Modifier les photos", style: TextStyle(color: Theme.of(context).primaryColor, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                photoUser(),
                SizedBox(height: MediaQuery.of(context).size.height*0.02),
                loading ?
                Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {  
                        
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                  ):
                  Material(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Theme.of(context).primaryColor ,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {  
                        if(selectedFile.length == 0){
                            aucunePhoto();
                        }else{
                          setState(() {
                            loading = true;
                          });
                          if(await Connection.tryConnection() == true){
                            uploadFunction(selectedFile);
                          }else{
                            setState(() {
                              loading = false;
                            });
                            connection();
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Continue",
                          style: TextStyle(color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void importer(){
      // widget.utilisateurs.photo.photo1 ="photot";
      Navigator.pushNamed(context, centreinteretRoute, arguments: widget.utilisateurs);
  }

  Widget photoUser(){

    var size = MediaQuery.of(context).size;

    if(selectedFile.length == 0){
      return  Container(
        margin: const EdgeInsets.only(right: 5),
        height: (size.height*0.23),
        width: (size.width*0.3),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300, width: 1, style: BorderStyle.solid),
        ),
        child: InkWell(
          onTap: (){
            selectImage();
          },
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
        ),
      );
    }else{
       return GridView.builder(
        physics: ScrollPhysics(),
         scrollDirection: Axis.vertical,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
           mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
                          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
         shrinkWrap: true,
         itemCount: selectedFile.length,
         itemBuilder: (context, index) {
           return Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(selectedFile[index].path)),
                  fit: BoxFit.cover
                ),
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
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
      );
    }
    
  }

  Future<void> selectImage() async {

    if(selectedFile != null){
      selectedFile.clear();
    }

    try{

      final List<XFile>? imgs = await picker.pickMultiImage();
      if(imgs!.isNotEmpty){
        selectedFile.addAll(imgs);
      }
      
      if(imgs.length>3){
        erreurImage();
      }

    }catch(e){
      print("erreur "+e.toString());
    }

    setState(() {
      
    });
  }

  void uploadFunction(List<XFile> images) async {

    // setState(() {
    //   loading = true;
    // });

    for(int i=0; i<images.length; i++){
      var localImagesUrl = await sauvegarderImage(File(images[i].path));
      localImageUrls.add(localImagesUrl.toString());

      print("chemin ${localImagesUrl.toString()}");
    }

    await DatabaseConnection().ajouterImages(localImageUrls);

    var result = await DatabaseConnection().afficher("photos");
    print("resultat $result");

    for(int i=0; i<images.length; i++){
      var imagesUrl = await upload(images[i]);
      imageUrls.add(imagesUrl.toString());
    }
    
    widget.utilisateurs.photo = imageUrls;
    setState(() {
      loading = false;
    });
    Navigator.pushNamed(context, centreinteretRoute, arguments: widget.utilisateurs);
    
  }

  Future<String> upload(XFile image) async {

    Reference reference = storage.ref().child("avatars").child(image.name);
    UploadTask uploadTask =  reference.putFile(File(image.path));
    await uploadTask.whenComplete((){
      // Navigator.pushNamed(context, centreinteretRoute, arguments: widget.utilisateurs);
    });

    return await reference.getDownloadURL();
  }

  Future<Null> erreurImage(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Vous devez choisi 3 photos"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  if(selectedFile.length>3){
                    setState(() {
                      selectedFile.removeLast();
                    });
                  }
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        }
    );
  }

  Future<Null> aucunePhoto(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuiillez choisiz 3 photos "),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        }
    );
  }

  Future<Null> connection(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text("Erreur"),
            content: Text("Veuillez vous connectez à internet"),
            actions: <Widget>[
              TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("OK"),
              )
            ],
          );
        }
    );
  }

  Future<String> sauvegarderImage(File image) async {

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
      final appDir = appDocDirectory.path;  
      var fileName = p.basename(image.path);  
      // fileName ="uploads/avatar/$fileName";
      print("nom du fichier $fileName");
      final savedImage = await image.copy('${appDir}/$fileName');

     return savedImage.path;  
  }

}


