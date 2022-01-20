import 'package:feeling/models/utilisateurs.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'dart:async';

class DatabaseConnection{

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path,"book.db");

    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db,int version) async{

          await db.execute("""
            CREATE TABLE users (idusers TEXT PRIMARY KEY, nom TEXT NOT NULL,
            age INTEGER NOT NULL, ville TEXT NOT NULL, pays TEXT NOT NULL, profession TEXT NOT NULL, 
            sexe TEXT NOT NULL, numero TEXT NOT NULL, propos TEXT NOT NULL)"""
          );

          await db.execute("""
            CREATE TABLE photos (idphoto INTEGER PRIMARY KEY, chemin TEXT NOT NULL)"""
          );

          await db.execute("""
            CREATE TABLE interets (idinteret INTEGER PRIMARY KEY, nom TEXT NOT NULL)"""
          );
          
        }
    );
  }


  Future<void> ajouterUtilisateurs(Utilisateurs utilisateurs) async{

    final db = await init(); //open database
    await db.rawInsert('INSERT INTO users (nom, age, ville, pays, profession, sexe, numero, propos) VALUES (?, ?, ?, ?, ?, ?, ?, ?)',
        [utilisateurs.nom, utilisateurs.age, utilisateurs.ville, utilisateurs.pays, utilisateurs.profession, utilisateurs.sexe, utilisateurs.numero, utilisateurs.propos]);
    
  }

  Future<void> ajouterInteret(List<dynamic> interet) async{

    final db = await init(); //open database
    for(int i=0; i<interet.length; i++){   
      if (kDebugMode) {
        print("tours $i");
      }  
      await db.rawInsert('INSERT INTO interets (nom) VALUES (?)',
        [ interet[i] ]);
    }
  }

  Future<void> ajouterImages(List<String> photo) async{

    final db = await init(); //open database
    for(int i=0; i<photo.length; i++){   
      if (kDebugMode) {
        print("tours $i");
      }  
      await db.rawInsert('INSERT INTO photos (chemin) VALUES (?)',
        [ photo[i] ]);
    }
  }

  afficher(table) async {
    final db = await init();
    return await db.query(table);

  }

}

