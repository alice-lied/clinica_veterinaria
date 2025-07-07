import 'dart:io';

import 'package:intl/intl.dart';

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
      idPet: map['idPet'] as int?,
      nome: map['nome'] as String,
      especie: map['especie'] as String,
      sexo: map['sexo'] as String,
      raca: map['raca'] as String,
      nascimento: map['nascimento'] != null ? DateTime.parse(map['nascimento']) : null,
      obs: map['obs'] as String?,
    );
  }

  String formatarData() {
    if (nascimento == null) return 'Data não disponível';
    return DateFormat('dd/MM/yyyy').format(nascimento!);
  }

}