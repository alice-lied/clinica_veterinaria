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

  Future<void> _selecionarData(BuildContext context) async {
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
      appBar: AppBar(
        title: const Text('Registrar pet', style: TextStyle(
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
          child: ListView(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Espécie', border: OutlineInputBorder()),
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
              SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Sexo', border: OutlineInputBorder()),
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
              SizedBox(height: 20),
              TextFormField(
                controller: _racaController,
                decoration: const InputDecoration(labelText: 'Raça', border: OutlineInputBorder()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () => _selecionarData(context),
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
              SizedBox(height: 20),
              TextFormField(
                controller: _obsController,
                decoration: InputDecoration(
                  labelText: 'Observações (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  _salvarPet();
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                  backgroundColor: Colors.green[200],
                ),
                child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.black87)),
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
          idPet: 1,
          nome: _nomeController.text,
          especie: _especie,
          sexo: _sexo,
          raca: _racaController.text,
          nascimento: _nascimento,
          obs: _obsController.text
        );
        await _petService.inserirPet(pet);

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