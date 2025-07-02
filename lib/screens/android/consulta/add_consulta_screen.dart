import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/model/consulta.dart';
import '/model/pet.dart';
import '/service/consulta_service.dart';
import '/service/pet_service.dart';

class AddConsultaScreen extends StatefulWidget {
  const AddConsultaScreen({super.key});

  @override
  AddConsultaScreenState createState() => AddConsultaScreenState();
}

class AddConsultaScreenState extends State<AddConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final ConsultaService _consultaService = ConsultaService();
  final PetService _petService = PetService();
  final TextEditingController _assuntoController = TextEditingController();
  late Future<List<Pet>> _petsFuture;
  Pet? _petSelecionado;
  DateTime? _dia = DateTime.now().add(const Duration (days: 2));

  @override
  void initState(){
    super.initState();
    _petsFuture = _petService.listarPets();
  }

  Future<void> _selecionarData(BuildContext context) async {
    final DateTime? selecao = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration (days: 180)),
    );
    if (selecao != null && selecao != _dia) {
      setState(() {
        _dia = selecao;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Marcar consulta', style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.white
          )),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: FutureBuilder<List<Pet>>(
            future: _petsFuture,
            builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Erro: ${snapshot.error}'));
              }
              final pets = snapshot.data ?? [];
              return ListView(
                children: [
                  SizedBox(height: 20),
                  DropdownButtonFormField<Pet>(
                    value: _petSelecionado,
                    items: pets.map((Pet pet) {
                      return DropdownMenuItem<Pet>(
                        value: pet,
                        child: Text(pet.nome),
                      );
                    }).toList(),
                    onChanged: (Pet? newValue) {
                      setState(() {
                        _petSelecionado = newValue;
                      });
                    },
                    decoration: const InputDecoration(
                      labelText: 'Pet',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null ? 'Selecione um paciente para a consulta' : null,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _assuntoController,
                    decoration: const InputDecoration(
                        labelText: 'Assunto',
                        border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
                  ),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: () => _selecionarData(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'Data',
                        border: OutlineInputBorder(),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_dia == null
                              ? 'Selecione a data'
                              : DateFormat('dd/MM/yyyy').format(_dia!),
                          ),
                          Icon(Icons.calendar_today),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _salvarConsulta,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.green[200],
                    ),
                    child: const Text('Marcar', style: TextStyle(fontSize: 18, color: Colors.black87)),
                  ),
                ] ,
              );
            },
          ),
        ),
      ),
    );
  }

  void _salvarConsulta() async {
    if (_formKey.currentState!.validate()) {
      try {
        final consulta = Consulta(
          idPet: _petSelecionado!.idPet,
          nomePet: _petSelecionado!.nome,
          dia: _dia,
          assunto: _assuntoController.text,
        );
        await _consultaService.inserirConsulta(consulta);

        print(consulta.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Consulta registrado com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar consulta: $e')),
        );
      }
    }
  }
}