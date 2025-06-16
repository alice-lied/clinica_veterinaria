class Consulta {
  final int? idConsulta;
  final int? idPet;
  final DateTime data;
  final String assunto;

  Consulta({
    this.idConsulta,
    required this.idPet,
    required this.data,
    required this.assunto,
  });

  Map<String, dynamic> toMap() {
    return {
      'idConsulta': idConsulta,
      'idPet': idPet,
      'data': data,
      'assunto': assunto,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      idConsulta: map['idConsulta'],
      idPet: map['idPet'],
      data: map['data'],
      assunto: map['assunto'],
    );
  }

}

/*  Consulta(this._id, this._data, this._assunto, this._pet);

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
  }*/