import 'package:feeling/db/db.dart';
import 'package:location/location.dart';

class Utilisateurs{
  String idutilisateurs;
  String nom;
  int age;
  String ville;
  String pays;
  String profession;
  String sexe;
  String numero;
  List<dynamic> photo;
  List<dynamic> interet;
  String propos;
  String email;
  String etablissement;
  String token;
  late LocationData position;
  late bool online;
  Utilisateurs({required this.nom, required this.idutilisateurs, required this.interet, required this.age, required this.numero, 
  required this.pays, required this.photo, required this.profession, required this.sexe, required this.ville, required this.propos
  , required this.online, required this.etablissement, required this.email, required this.token});

  factory Utilisateurs.fromMap(Map<String, dynamic> data, dynamic id){
    return Utilisateurs(
        idutilisateurs: id,
        nom: data['nom'],
        age: data['age'],
        ville: data['ville'],
        pays: data['pays'],
        profession: data['profession'],
        sexe: data['sexe'],
        numero: data['numero'],
        photo: data['photo'],
        interet: data['interet'],
        propos: data['propos'],
        online: data['online'],
        token: data['token'],
        email: data['email'] ?? "" ,
        etablissement: data['etablissement'] ?? "",
    );
  }

  static Future<String> getUserId() async {
    
    String id="";
    DatabaseConnection connection = DatabaseConnection();
    
    await connection.getUtilisateurs().then((value){
      id = value[0].idutilisateurs;
    });

    return id;
  }

  static Future<Utilisateurs> getCurrentUser() async {
    
    Utilisateurs? utilisateurs;
    DatabaseConnection connection = DatabaseConnection();
    
    await connection.getUtilisateurs().then((value){
      utilisateurs = value[0];
    });

    return utilisateurs as Utilisateurs;
  }


}


