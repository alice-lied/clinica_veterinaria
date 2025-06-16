import '../model/consulta.dart';
import '../persistence/consulta_dao.dart';


class ConsultaService {
  final ConsultaDao _consultaDao = ConsultaDao();

  Future<int> addConsulta(Consulta consulta) async {
    return await _consultaDao.insertConsulta(consulta);
  }

  Future<List<Consulta>> getConsultas() async {
    return await _consultaDao.getAllConsultas();
  }
}