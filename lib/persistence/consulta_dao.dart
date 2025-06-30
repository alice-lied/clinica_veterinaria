import '../database/open_database.dart';
import '../model/consulta.dart';

class ConsultaDao {
  static const String table = 'consultas';

  Future<int> insertConsulta(Consulta consulta) async {
    final db = await AppDatabase().database;
    return db.insert(table, consulta.toMap());
  }

  Future<List<Consulta>> getAllConsultas() async {
    final db = await AppDatabase().database;
    final result = await db.query(table);
    return result.map((map) => Consulta.fromMap(map)).toList();
  }

}