class Pet {
  final int _id;
  final String _nome;
  final String _especie;
  final String _sexo;
  final String _raca;
  final DateTime _nascimento;
  final String _obs;

  Pet(this._id, this._nome, this._especie, this._sexo, this._raca,
      this._nascimento, this._obs);

  int get id{
    return _id;
  }

  String get nome{
    return _nome;
  }

  String get especie{
    return _especie;
  }

  String get sexo{
    return _sexo;
  }

  String get raca{
    return _raca;
  }

  DateTime get nascimento{
    return _nascimento;
  }

  String get obs{
    return _obs;
  }
}