import 'package:sqflite/sqflite.dart';

import '../database/open_database.dart';
import '../model/consulta.dart';

class ConsultaDao {
  static const String table = 'consultas';

  Future<int> inserirConsulta(Consulta consulta) async {
    final db = await AppDatabase().database;
    // Remove o id para que o SQLite gere um novo
    final mapa = consulta.toMap();
    mapa.remove('idConsulta'); // Garante que o SQLite gere o ID automaticamente

    // Insere e retorna o ID gerado
    return await db.insert(
      'consultas',
      mapa,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Consulta>> listarConsultas() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Consulta.fromMap(map)).toList();
  }

  Future<int> editarConsulta(Consulta consulta) async {
    final db = await AppDatabase().database;
    return db.update(table, consulta.toMap(), where: 'idConsulta = ?', whereArgs: [consulta.idConsulta]);
  }

  Future<void> excluirConsulta(int? idConsulta) async {
    final db = await AppDatabase().database;
    await db.delete(table, where: 'idConsulta = ?', whereArgs: [idConsulta]);
  }

}