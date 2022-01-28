
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feeling/models/utilisateurs.dart';
import 'package:localstore/localstore.dart';
import 'package:location/location.dart';

class LocalDatabase {
  
  final db = Localstore.instance;
  
  Future<void> addUsers(Utilisateurs utilisateurs, LocationData locationData) async {

    db.collection('users').doc(utilisateurs.idutilisateurs).set({
      "nom" : utilisateurs.nom,
      "age" : utilisateurs.age,
      "ville" : utilisateurs.ville,
      "pays" : utilisateurs.pays,
      "profession" : utilisateurs.profession,
      "sexe" : utilisateurs.sexe,
      "numero" : utilisateurs.numero,
      "photo" : utilisateurs.photo,
      "interet" : utilisateurs.interet,
      "propos" : utilisateurs.propos,
      "localisation": GeoPoint(locationData.latitude as double, locationData.longitude as double),
      "date_creation": DateTime.now()
    });

  }


  
}