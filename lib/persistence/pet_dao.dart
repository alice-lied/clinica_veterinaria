import 'package:sqflite/sqflite.dart';

import '../database/open_database.dart';
import '../model/pet.dart';

class PetDao {
  static const String table = 'pets';

  Future<int> inserirPet(Pet pet) async {
    final db = await AppDatabase().database;
    // Remove o id para que o SQLite gere um novo
    final mapa = pet.toMap();
    mapa.remove('idPet'); // Garante que o SQLite gere o ID automaticamente

    // Insere e retorna o ID gerado
    return await db.insert(
      'pets',
      mapa,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Pet>> listarPets() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Pet.fromMap(map)).toList();
  }

  Future<int> editarPet(Pet pet) async {
    final db = await AppDatabase().database;
    return db.update(table, pet.toMap(), where: 'idPet = ?', whereArgs: [pet.idPet]);
  }

  Future<void> excluirPet(int? idPet) async {
    final db = await AppDatabase().database;
    await db.delete(table, where: 'idPet = ?', whereArgs: [idPet]);
  }

}