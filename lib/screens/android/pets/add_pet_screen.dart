import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/model/pet.dart';
import '/service/pet_service.dart';

class AddPetScreen extends StatefulWidget {
  const AddPetScreen({super.key});

  @override
  AddPetScreenState createState() => AddPetScreenState();
}

class AddPetScreenState extends State<AddPetScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _racaController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();
  final PetService _petService = PetService();
  DateTime? _nascimento;
  String _especie = 'cachorro';
  String _sexo = 'macho';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _nascimento) {
      setState(() {
        _nascimento = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrar pet')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Espécie',),
                value: _especie,
                items: <String>['cachorro', 'gato']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'cachorro' ? 'Cachorro' : 'Gato'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _especie = newValue!;
                  });
                },
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sexo',),
                value: _sexo,
                items: <String>['macho', 'fêmea']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value == 'macho' ? 'Macho' : 'Fêmea'),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _sexo = newValue!;
                  });
                },
              ),
              TextFormField(
                controller: _racaController,
                decoration: const InputDecoration(labelText: 'Raça'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Data de Nascimento',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        _nascimento == null
                            ? 'Selecione a data'
                            : DateFormat('dd/MM/yyyy').format(_nascimento!),
                      ),
                      Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              TextFormField(
                controller: _obsController,
                decoration: InputDecoration(
                  labelText: 'Observações (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              ElevatedButton(
                onPressed: (){
                  _salvarPet();
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _salvarPet() async {
    if (_formKey.currentState!.validate()) {
      try {
        final pet = Pet(
          nome: _nomeController.text,
          especie: _especie,
          sexo: _sexo,
          raca: _racaController.text,
          nascimento: _nascimento,
          obs: _obsController.text
        );
        await _petService.addPet(pet);

        print(pet.toMap());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Pet registrado com sucesso!')),
        );

        Navigator.pop(context);
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar pet: $e')),
        );
      }
    }
  }
}