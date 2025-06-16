import '../database/openDatabase.dart';
import '../model/pet.dart';

class PetDao {
  static const String table = 'pets';

  Future<int> insertPet(Pet pet) async {
    final db = await AppDatabase().database;
    return db.insert(table, pet.toMap());
  }

  Future<List<Pet>> getAllPets() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Pet.fromMap(map)).toList();
  }

}

/*
import 'package:clinica_veterinaria/database/openDatabase.dart';

import '../model/pet.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PetDAO{
  final Database _database;

  static const String _nomeTabela = 'pets';
  static const String _columnId = 'id';
  static const String _columnNome = 'nome';
  static const String _columnEspecie = 'especie';
  static const String _columnSexo = 'sexo';
  static const String _columnRaca = 'raca';
  static const String _columnNascimento = 'nascimento';
  static const String _columnObs = 'obs';

  static const String sqlTabelaPets = 'CREATE TABLE $_nomeTabela ('
    '$_columnId INTEGER PRIMARY KEY, '
    '$_columnNome TEXT, '
    '$_columnEspecie TEXT, '
    '$_columnSexo TEXT, '
    '$_columnRaca TEXT, '
    '$_columnNascimento TEXT, '
    '$_columnObs TEXT )';

  PetDAO(this._database);

  adicionar(Pet p) async{
    final Database db = await getDatabase();
    await db.insert(_nomeTabela, p.toMap());
  }

}*/