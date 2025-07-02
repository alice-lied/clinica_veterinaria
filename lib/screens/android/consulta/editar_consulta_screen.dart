import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/model/pet.dart';
import '/model/consulta.dart';
import '/service/consulta_service.dart';
import '/service/pet_service.dart';

class EditarConsultaScreen extends StatefulWidget {
  final Consulta consulta;
  const EditarConsultaScreen({super.key, required this.consulta});

  @override
  _EditarConsultaScreenState createState() => _EditarConsultaScreenState();

}

class _EditarConsultaScreenState extends State<EditarConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assuntoController = TextEditingController();
  final ConsultaService _consultaService = ConsultaService();
  final PetService _petService = PetService();
  late Future<List<Pet>> _petsFuture;
  DateTime? _dia;
  Pet? _petSelecionado;

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

  @override void initState() {
    super.initState();
    _petsFuture = _petService.listarPets();
    _dia = widget.consulta.dia;
    _assuntoController.text = widget.consulta.assunto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Editar consulta', style: TextStyle(
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
                    decoration: const InputDecoration(labelText: 'Assunto', border: OutlineInputBorder()),
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
                    child: const Text('Salvar', style: TextStyle(fontSize: 18, color: Colors.black87)),
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
        final consultaEditada = Consulta(
          idPet: _petSelecionado!.idPet,
          nomePet: _petSelecionado!.nome,
          dia: _dia,
          assunto: _assuntoController.text,
        );
        await _consultaService.editarConsulta(consultaEditada);//debug

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Dados editados com sucesso!')),
        );

        Navigator.of(context).pop(true);
      } catch (e) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao editar dados: $e')),
        );
      }
    }
  }
}