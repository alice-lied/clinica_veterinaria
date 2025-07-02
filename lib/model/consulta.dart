import 'package:intl/intl.dart';

class Consulta {
  final int? idConsulta;
  final int? idPet;
  final String nomePet;
  final DateTime? dia;
  final String assunto;

  Consulta({
    this.idConsulta,
    required this.idPet,
    required this.nomePet,
    this.dia,
    required this.assunto,
  });

  Map<String, dynamic> toMap() {
    return {
      'idConsulta': idConsulta,
      'idPet': idPet,
      'nomePet': nomePet,
      'dia': dia?.toIso8601String(),
      'assunto': assunto,
    };
  }

  factory Consulta.fromMap(Map<String, dynamic> map) {
    return Consulta(
      idConsulta: map['idConsulta'] as int?,
      idPet: map['idPet'] as int,
      nomePet: map['nomePet'] as String,
      dia: map['dia'] != null
          ? DateTime.tryParse(map['dia'] as String)
          : null,
      assunto: map['assunto'] as String,
    );
  }

  String formatarData() {
    if (dia == null) return 'Data não disponível';
    return DateFormat('dd/MM/yyyy').format(dia!);
  }

}