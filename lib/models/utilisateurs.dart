
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
  late LocationData position;
  Utilisateurs({required this.nom, required this.idutilisateurs, required this.interet, required this.age, required this.numero, 
  required this.pays, required this.photo, required this.profession, required this.sexe, required this.ville, required this.propos});

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


