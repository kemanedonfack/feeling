import 'package:flutter/cupertino.dart';

class Interet{
  IconData icone;
  String nom;
  Interet({required this.icone, required this.nom});

  Map toMap() {
    return {
      'nom': nom,
    };
  }
}

