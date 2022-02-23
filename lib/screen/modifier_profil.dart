import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feeling/controllers/utilisateur_controller.dart';
import 'package:feeling/db/db.dart';
import 'package:feeling/localization/language_constants.dart';
import 'package:feeling/models/interets.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:feeling/utile/utile.dart';
import 'package:path/path.dart' as p;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:feeling/routes/route_name.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ModifierProfilScreen extends StatefulWidget {
  
  
  final Utilisateurs utilisateurs;
  const ModifierProfilScreen(this.utilisateurs, {Key? key}) : super(key: key);

  @override
  _ModifierProfilScreenState createState() => _ModifierProfilScreenState();
}

class _ModifierProfilScreenState extends State<ModifierProfilScreen> {

  
  final ImagePicker picker = ImagePicker();
  List<File> selectedFile = [];
  List<String> mesinteret = [];
  List<String> localImageUrls = [];
  FirebaseStorage storage = FirebaseStorage.instance;
  bool isloading = false;
  
  final _formKey = GlobalKey<FormState>();

  UtilisateurController utilisateurController = UtilisateurController();
  TextEditingController nomcontroller = TextEditingController();
  TextEditingController proposcontroller = TextEditingController();
  TextEditingController entreprisecontroller = TextEditingController();
  TextEditingController etablissementcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController villecontroller = TextEditingController();
  TextEditingController payscontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController professioncontroller = TextEditingController();
  TextEditingController country=TextEditingController();
  TextEditingController state=TextEditingController();
  TextEditingController city=TextEditingController();

  List<Interet> listinteret = [
    Interet(nom: "Shopping", icone: Icons.shopping_bag_outlined),
    Interet(nom: "Photographie", icone: Icons.camera_alt_outlined),
    Interet(nom: "Basket", icone: Icons.sports_basketball_outlined),
    Interet(nom: "Course", icone: Icons.directions_run),
    Interet(nom: "Music", icone: Icons.music_note),
    Interet(nom: "Cinéma", icone: Icons.local_movies_rounded),
    Interet(nom: "Hanball", icone: Icons.sports_handball),
    Interet(nom: "Jeux vidéo", icone: Icons.sports_esports_rounded),
    Interet(nom: "Art", icone: Icons.format_paint),
    Interet(nom: "Cuisine", icone: Icons.food_bank),
    Interet(nom: "Football", icone: Icons.sports_soccer),
    Interet(nom: "Lecture", icone: Icons.chrome_reader_mode),
    Interet(nom: "Facebook", icone: Icons.facebook),
    Interet(nom: "Voyage", icone: Icons.travel_explore),
    Interet(nom: "Business", icone: Icons.business),
    Interet(nom: "Agriculture", icone: Icons.agriculture),
    Interet(nom: "bénévolat", icone: Icons.volunteer_activism),
    Interet(nom: "Tenis", icone: Icons.sports_tennis),
    Interet(nom: "Lutte", icone: Icons.sports_kabaddi),
    Interet(nom: "Boxes", icone: Icons.sports_mma),
    Interet(nom: "volleyball", icone: Icons.sports_volleyball),
  ];
  

  @override
  void initState() {
    initialisation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
  var size =MediaQuery.of(context).size;
 
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(getTranslated(context,'modifier_profil'), style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor)
        ),
        actions: [
          InkWell(
            onTap: (){
              enregistrement();
            },
            child: Center(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(getTranslated(context,'enregistrer'), style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold), ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),        
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: MediaQuery.of(context).size.height * 0.28,
                        crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
                        shrinkWrap: true,
                        itemCount: widget.utilisateurs.photo.length+1,
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
                                child: isloading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)) : Icon(Icons.add_a_photo, size: size.width*0.1, color: Theme.of(context).primaryColor),
                              ),
                            );
                          }else{
                            return Container(
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    widget.utilisateurs.photo[index-1],
                                    cacheManager: customCacheManager,
                                  ),
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
                                        widget.utilisateurs.photo.removeAt(index-1);
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
                    ),
                  ),  
                  SizedBox(height: MediaQuery.of(context).size.height*0.03),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'a_propos'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    controller: proposcontroller,
                    minLines: 2,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'nom'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                      controller: nomcontroller,
                      decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'age'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                      controller: agecontroller,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 5),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'profession'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    controller: professioncontroller,
                    decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  // SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Text(getTranslated(context,'entreprise'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  // ),
                  // TextFormField(
                  //   controller: entreprisecontroller,
                  //   decoration: const InputDecoration(
                  //     enabled: true,
                  //     border: OutlineInputBorder(
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  //     filled: true,
                  //     fillColor: Colors.white,
                  //   ),
                  // ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'etablissement'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    controller: etablissementcontroller,
                    decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Lieu de Résidence", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, updateCountryRoute, arguments: widget.utilisateurs);
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Text("${widget.utilisateurs.ville}, ${widget.utilisateurs.pays}"),
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'centre_interet'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, updateInteretRoute, arguments: widget.utilisateurs);
                    },
                    child: Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: [
                            for(int i=0; i< widget.utilisateurs.interet.length; i++)
                              Text("${widget.utilisateurs.interet[i]}, "),
                          ],
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.01),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(getTranslated(context,'email'), style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.047, fontWeight: FontWeight.bold),),
                  ),
                  TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      enabled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initialisation(){
    
    setState(() {
      nomcontroller.text = widget.utilisateurs.nom;
      agecontroller.text = widget.utilisateurs.age.toString();
      proposcontroller.text = widget.utilisateurs.propos;
      professioncontroller.text = widget.utilisateurs.profession;
      emailcontroller.text = widget.utilisateurs.email;
      etablissementcontroller.text = widget.utilisateurs.etablissement;
      payscontroller.text = widget.utilisateurs.pays;
      villecontroller.text = widget.utilisateurs.ville;
    });
  }

  void enregistrement() async{

    if(nomcontroller.text.isNotEmpty || agecontroller.text.isNotEmpty || proposcontroller.text.isNotEmpty || professioncontroller.text.isNotEmpty){
      widget.utilisateurs.nom = nomcontroller.text;
      widget.utilisateurs.age = int.parse(agecontroller.text);
      widget.utilisateurs.propos = proposcontroller.text;
      widget.utilisateurs.etablissement = etablissementcontroller.text;
      widget.utilisateurs.email = emailcontroller.text;
      widget.utilisateurs.profession = professioncontroller.text;

      if(selectedFile.isNotEmpty){

        for(int i=0; i<selectedFile.length; i++){
          var localImagesUrl = await sauvegarderImage(File(selectedFile[i].path));
          localImageUrls.add(localImagesUrl.toString());
        }
        await DatabaseConnection().deleteImage();
        await DatabaseConnection().ajouterImages(localImageUrls);
      }
      /// suppression des informations de l'utilisateurs local 
      /// puis insersion des nouvelles information
      await DatabaseConnection().deleteUtilisateurs();
      await DatabaseConnection().ajouterUtilisateurs(widget.utilisateurs);
      utilisateurController.updateUtilisateurs(widget.utilisateurs);
      Navigator.pushNamedAndRemoveUntil(context, tabRoute, (route) => false);

    }else{
      erreur();
    }

    
  }


  void ajouter(String nom) {
    if(!mesinteret.contains(nom)){
      setState(() {
        mesinteret.add(nom);
      });
    }else{
      setState(() {
        mesinteret.removeWhere((val) => val == nom);
      });
    }
  }

  Future<void> selectImage() async {

    setState(() {
      isloading = true;
    });

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
          var imagesUrl = await upload(croppedFile!);

          setState(() {
            widget.utilisateurs.photo.add(imagesUrl.toString());
          });
  
          selectedFile.add(croppedFile);

          setState(() {
            isloading = false;
          });
        
      }
      

    }catch(e){
      if (kDebugMode) {
        print("erreur "+e.toString());
      }
    }
  }

  // Future<void> selectImage() async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   try{

  //     final List<XFile>? imgs = await picker.pickMultiImage();
  //     if(imgs!.isNotEmpty){

  //       selectedFile.addAll(imgs);

  //       for(int i=0; i<imgs.length; i++){
 
  //         ImageCropper imageCropper = ImageCropper();
    
  //         XFile croppedFile = await imageCropper.cropImage(
  //           sourcePath: imgs[i].path,
  //           aspectRatioPresets: [
  //             CropAspectRatioPreset.square,
  //             CropAspectRatioPreset.ratio3x2,
  //             CropAspectRatioPreset.original,
  //             CropAspectRatioPreset.ratio4x3,
  //             CropAspectRatioPreset.ratio16x9
  //           ],
  //           androidUiSettings: const AndroidUiSettings(
  //               toolbarTitle: 'Cropper',
  //               toolbarColor: Colors.deepOrange,
  //               toolbarWidgetColor: Colors.white,
  //               initAspectRatio: CropAspectRatioPreset.original,
  //               lockAspectRatio: false),
  //           iosUiSettings: const IOSUiSettings(
  //             minimumAspectRatio: 1.0,
  //           )
  //         ) as XFile;

  //         var imagesUrl = await upload(croppedFile);
          
  //         setState(() {
  //           widget.utilisateurs.photo.add(imagesUrl.toString());
  //         });

  //       }
  //       setState(() {
  //         isloading = false;
  //       });
  //     }

  //   }catch(e){
  //     if (kDebugMode) {
  //       print("erreur "+e.toString());
  //     }
  //   }
  // }

  Future<String> upload(File image) async {

    Reference reference = storage.ref().child("avatars").child(DateTime.now().millisecondsSinceEpoch.toString()+widget.utilisateurs.age.toString());
    File image1 = await compress(File(image.path));
    UploadTask uploadTask =  reference.putFile(File(image1.path));
    await uploadTask.whenComplete((){
      // Navigator.pushNamed(context, centreinteretRoute, arguments: widget.utilisateurs);
    });

    return await reference.getDownloadURL();
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

  Future<String> sauvegarderImage(File image) async {

    Directory appDocDirectory = await getApplicationDocumentsDirectory();
      final appDir = appDocDirectory.path;  
      var fileName = p.basename(image.path);  
      // fileName ="uploads/avatar/$fileName";
      if (kDebugMode) {
        print("nom du fichier $fileName");
      }
      final savedImage = await image.copy('$appDir/$fileName');

     return savedImage.path;  
  }

  Future<void> erreur(){
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return AlertDialog(
            title: Text(getTranslated(context,'title_erreur')),
            content: Text(getTranslated(context,'renseigner_information')),
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

  // Future<File?> _cropImage(filePath) async {

  //   ImageCropper imageCropper = ImageCropper();
    
  //   File croppedFile = await imageCropper.cropImage(
  //     sourcePath: filePath,
  //      aspectRatioPresets: [
  //       CropAspectRatioPreset.square,
  //       CropAspectRatioPreset.ratio3x2,
  //       CropAspectRatioPreset.original,
  //       CropAspectRatioPreset.ratio4x3,
  //       CropAspectRatioPreset.ratio16x9
  //     ],
  //     androidUiSettings: const AndroidUiSettings(
  //         toolbarTitle: 'Cropper',
  //         toolbarColor: Colors.deepOrange,
  //         toolbarWidgetColor: Colors.white,
  //         initAspectRatio: CropAspectRatioPreset.original,
  //         lockAspectRatio: false),
  //     iosUiSettings: const IOSUiSettings(
  //       minimumAspectRatio: 1.0,
  //     )
  //   );
  //   return croppedFile;
  // }

}
