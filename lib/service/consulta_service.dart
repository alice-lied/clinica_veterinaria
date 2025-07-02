import '../model/consulta.dart';
import '../persistence/consulta_dao.dart';

class ConsultaService {
  final ConsultaDao _consultaDao = ConsultaDao();

  Future<int> inserirConsulta(Consulta consulta) async {
    return await _consultaDao.inserirConsulta(consulta);
  }

  Future<List<Consulta>> listarConsultas() async {
    return await _consultaDao.listarConsultas();
  }

  Future<int> editarConsulta(Consulta consulta) async {
    return await _consultaDao.editarConsulta(consulta);
  }

  Future<void> excluirConsulta(int? id) async {
    return await _consultaDao.excluirConsulta(id);
  }

}