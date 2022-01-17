
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
  Utilisateurs({required this.nom, required this.idutilisateurs, required this.interet, required this.age, required this.numero, 
  required this.pays, required this.photo, required this.profession, required this.sexe, required this.ville, required this.propos});

  // Map<String, dynamic> toHashMap() {
  //   return {
  //     'idutilisateurs': idutilisateurs,
  //     'nom': nom,
  //     'age': age,
  //     'ville': ville,
  //     'pays': pays,
  //     'profession': profession,
  //     'sexe': sexe,
  //     'numero': numero,
  //     'photo': photo,
  //     'interet': interet,
  //     'propos': propos,
  //   };
  // }

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

  // List<Utilisateurs> utilisateursListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return utilisateursFromSnapshot(doc);
  //   }).toList();
  // }

  // Utilisateurs utilisateursFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
  //   var data = snapshot.data();
  //   if (data == null) throw Exception("utilisateurs not found");
  //   return Utilisateurs.fromMap(data);
  // }

  // Utilisateurs.fromJson(Map<String, Object> json)
  //   : this(
  //       idutilisateurs: json['idutilisateurs'],
  //       nom: json['nom'],
  //       age: json['age'],
  //       ville: json['ville'],
  //       pays: json['pays'],
  //       profession: json['profession'],
  //       sexe: json['sexe'],
  //       numero: json['numero'],
  //       photo: json['photo'],
  //       interet: json['interet'],
  //       propos: json['propos'],
  //   );

  // Map<String, Object> toJson() {
  //   return {
  //     'idutilisateurs': idutilisateurs,
  //     'nom': nom,
  //     'age': age,
  //     'ville': ville,
  //     'pays': pays,
  //     'profession': profession,
  //     'sexe': sexe,
  //     'numero': numero,
  //     'photo': photo,
  //     'interet': interet,
  //     'propos': propos,
  //   };
  // }

}


