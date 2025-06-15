import 'package:clinica_veterinaria/model/pet.dart';

class Consulta {
  final int _id;
  final DateTime _data;
  final String _assunto;
  final Pet _pet;

  Consulta(this._id, this._data, this._assunto, this._pet);

  int get id{
    return _id;
  }

  DateTime get data{
    return _data;
  }

  String get assunto{
    return _assunto;
  }

  Pet get pet{
    return _pet;
  }

}