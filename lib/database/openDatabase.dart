import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  static Database? _database;

  factory AppDatabase() => _instance;

  AppDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'clinica_veterinaria.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE pets(
            idPet INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            especie TEXT,
            sexo TEXT,
            raca TEXT,
            nascimento TEXT,
            obs TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE consultas(
            idConsulta INTEGER PRIMARY KEY AUTOINCREMENT,
            idPet INTEGER,
            data TEXT,
            assunto TEXT,
            FOREIGN KEY (idPet) REFERENCES pets (idPet)
          )
        ''');

      },
    );
  }
}

/*
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'clinica_database.db');

  return openDatabase(
    path,
    onCreate: (db, version){

    },
    version: 1);
}*/