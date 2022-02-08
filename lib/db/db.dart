import 'package:feeling/models/like.dart';
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

          await db.execute("""
            CREATE TABLE likes (idlike INTEGER PRIMARY KEY, idReceiver TEXT NOT NULL)"""
          );

          await db.execute("""
            CREATE TABLE dislikes (iddislike INTEGER PRIMARY KEY, idReceiver TEXT NOT NULL)"""
          );
          
        }
    );
  }

  Future<void> ajouterLikes(Likes likes) async{

    final db = await init(); //open database
    await db.rawInsert('INSERT INTO likes (idReceiver) VALUES ( ?)',
      [likes.idReceiver]);
    
  }

  Future<void> ajouterDisLikes(Likes dislikes) async{

    final db = await init(); //open database
    await db.rawInsert('INSERT INTO dislikes (idReceiver) VALUES (?)',
      [dislikes.idReceiver]);
    
  }

  Future<void> ajouterUtilisateurs(Utilisateurs utilisateurs) async{

    final db = await init(); //open database
    await db.rawInsert('INSERT INTO users (idusers, nom, age, ville, pays, profession, sexe, numero, propos) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [utilisateurs.idutilisateurs, utilisateurs.nom, utilisateurs.age, utilisateurs.ville, utilisateurs.pays, utilisateurs.profession, utilisateurs.sexe, utilisateurs.numero, utilisateurs.propos]);
    
  }

  Future<List<Utilisateurs>> getUtilisateurs() async {
    final db = await init();

    final List<Map<String, dynamic>> maps = await db.query('users');
    if (kDebugMode) {
      print("resultat $maps");
    }

     final List<Map<String, dynamic>> interets = await db.rawQuery('select nom from interets');
     List<dynamic> listinterets = [];

    for(int i =0; i<interets.length; i++){
      listinterets.add(interets[i]['nom']);
    }

     final List<Map<String, dynamic>> photos = await db.rawQuery('select chemin from photos');
     List<dynamic> listphotos = [];

    for(int i =0; i<photos.length; i++){
      listphotos.add(photos[i]['chemin']);
    }
    
    return List.generate(maps.length, (i) {
      return Utilisateurs(
        idutilisateurs: maps[i]['idusers'],
        nom: maps[i]['nom'],
        interet: listinterets,
        numero: maps[i]['numero'],
        pays: maps[i]['pays'],
        ville: maps[i]['ville'],
        sexe: maps[i]['sexe'],
        profession: maps[i]['profession'],
        propos: maps[i]['propos'],
        photo: listphotos,
        age: maps[i]['age'],
        online: false
      );
    });
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

  getLikeAndDisLike(table) async {
    final db = await init();
    return await db.rawQuery('select idReceiver from $table');
  }



} 

