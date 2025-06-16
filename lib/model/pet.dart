class Pet {
  final int? idPet;
  final String nome;
  final String especie;
  final String sexo;
  final String raca;
  final DateTime? nascimento;
  final String? obs;

  Pet({
    this.idPet,
    required this.nome,
    required this.especie,
    required this.sexo,
    required this.raca,
    this.nascimento,
    this.obs,
  });

  Map<String, dynamic> toMap(){
    return{
      'idPet': idPet,
      'nome': nome,
      'especie': especie,
      'sexo': sexo,
      'raca': raca,
      'nascimento': nascimento?.toIso8601String(),
      'obs': obs,
    };
  }

  factory Pet.fromMap(Map<String, dynamic> map) {
    return Pet(
      idPet: map['idPet'],
      nome: map['nome'],
      especie: map['especie'],
      sexo: map['sexo'],
      raca: map['raca'],
      nascimento: map['nascimento'] != null ? DateTime.parse(map['birthDate']) : null,
      obs: map['obs'],
    );
  }

}