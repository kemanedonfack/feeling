import 'dart:io';
import 'package:feeling/localization/language_constants.dart';
import 'package:feeling/utile/utile.dart';
import 'package:feeling/db/db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:path_provider/path_provider.dart';

 
class UploadImageScreen extends StatefulWidget {
  
  final Utilisateurs utilisateurs;
  const UploadImageScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _UploadImageScreenState createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  
  final ImagePicker picker = ImagePicker();
  List<File> selectedFile = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  List<String> imageUrls = [];
  List<String> localImageUrls = [];
  
  late GlobalKey<ScaffoldState> globalKey;
  // List<String> imageUrls = <String>[];
  bool loading = false;
  
  // List<Asset> images = <Asset>[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                Text(getTranslated(context,'importer_photo'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: MediaQuery.of(context).size.width*0.05)
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01),
                Row(
                  children: [
                    Text(getTranslated(context,'choisir_photo'), style: TextStyle(fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.width*0.04)
                    ),
                  ],
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
                        if(selectedFile.isEmpty || selectedFile.length>3){
                            aucunePhoto();
                        }else{
                          setState(() {
                            loading = true;
                          });
                          if(await tryConnection() == true){
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
                        child: Text(getTranslated(context,'btn_continue'),
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
    
    return GridView.builder(
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        shrinkWrap: true,
        itemCount: selectedFile.length+1,
        itemBuilder: (context, index) {
          if(index == 0){
            return Container(
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
                child: Icon(Icons.add_a_photo, size: size.width*0.1, color: Theme.of(context).primaryColor),
              ),
            );
           }else{
            return Container(
              margin: const EdgeInsets.only(right: 5),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(selectedFile[index-1].path)),
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
                  InkWell(
                    onTap: (){
                      setState(() {
                        selectedFile.removeAt(index-1);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        radius: 12,
                        child: Icon(Icons.close, size: 20, color: Theme.of(context).primaryColor),
                        backgroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
            ),
          );
        }
      }
    );
  }

  Future<File> compress(File imagePath) async{

    int taille = imagePath.lengthSync();

    if(taille < 150000){
      return imagePath;
    }
    else if(taille > 150000 && taille < 500000) {

      final newPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(imagePath.path)}');
      final result = await FlutterImageCompress.compressAndGetFile(
        imagePath.absolute.path,
        newPath,
        quality: 40,
      );
      return result!;
    }

    else if(taille > 500000 && taille < 800000) {

      final newPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(imagePath.path)}');
      final result = await FlutterImageCompress.compressAndGetFile(
        imagePath.absolute.path,
        newPath,
        quality: 30,
      );
      return result!;
    }

    else if(taille > 800000) {

      final newPath = p.join((await getTemporaryDirectory()).path, '${DateTime.now()}.${p.extension(imagePath.path)}');
      final result = await FlutterImageCompress.compressAndGetFile(
        imagePath.absolute.path,
        newPath,
        quality: 20,
      );
      return result!;
    }

    return imagePath;
  }

  Future<void> selectImage() async {

    try{

      final XFile? imgs = await picker.pickImage(source: ImageSource.gallery);
      if(imgs != null){

        ImageCropper imageCropper = ImageCropper();
    
          File? croppedFile = await imageCropper.cropImage(
            sourcePath: imgs.path,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
            androidUiSettings: const AndroidUiSettings(
                toolbarTitle: 'Redimensionnement',
                toolbarColor: Colors.deepOrange,
                toolbarWidgetColor: Colors.white,
                initAspectRatio: CropAspectRatioPreset.original,
                lockAspectRatio: false),
            iosUiSettings: const IOSUiSettings(
              minimumAspectRatio: 1.0,
            )
          );
        
        selectedFile.add(croppedFile!);
        
      }
      

    }catch(e){
      if (kDebugMode) {
        print("erreur "+e.toString());
      }
    }
  }

  void uploadFunction(List<File> images) async {

    // setState(() {
    //   loading = true;
    // });

    for(int i=0; i<images.length; i++){
      var localImagesUrl = await sauvegarderImage(File(images[i].path));
      localImageUrls.add(localImagesUrl.toString());

      if (kDebugMode) {
        print("chemin ${localImagesUrl.toString()}");
      }
    }

    await DatabaseConnection().ajouterImages(localImageUrls);

    // var result = await DatabaseConnection().afficher("photos");
    // if (kDebugMode) {
    //   print("resultat $result");
    // }

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

  Future<String> upload(File image) async {
    // print("image nom");
    Reference reference = storage.ref().child("avatars").child(DateTime.now().millisecondsSinceEpoch.toString()+widget.utilisateurs.age.toString());
    // print("image compression");
    File image1 = await compress(File(image.path));
    // print("image envoi");
    UploadTask uploadTask =  reference.putFile(File(image1.path));
    await uploadTask.whenComplete((){
      // Navigator.pushNamed(context, centreinteretRoute, arguments: widget.utilisateurs);
    });

    return await reference.getDownloadURL();
  }

  Future<void> erreurImage(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: const Text("Erreur"),
            content: const Text("Vous devez choisi 3 photos"),
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
                child: const Text("OK"),
              )
            ],
          );
        }
    );
  }

  Future<void> aucunePhoto(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'veillez_choisir_photo')),
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

  Future<void> connection(){
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

  Future<String> sauvegarderImage(File image) async {

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
      final appDir = appDocDirectory.path;  
      var fileName = p.basename(image.path);  
      // fileName ="uploads/avatar/$fileName";
      
      final savedImage = await image.copy('$appDir/$fileName');

     return savedImage.path;  
  }

}


