import 'package:flutter/material.dart';

import '../../../model/pet.dart';

class VisualizarPetScreen extends StatefulWidget {
  final Pet pet;
  const VisualizarPetScreen({super.key, required this.pet});

  @override
  _VisualizarPetScreenState createState() => _VisualizarPetScreenState();

}

class _VisualizarPetScreenState extends State<VisualizarPetScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            Image.asset('assets/logo_vet.png', height: 45),
            const SizedBox(width: 10),
            const Text('Clínica Patinhas',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),),],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 10.0,
              ),
              child: Text('Dados do pet',
                  style: Theme.of(context).textTheme.headlineLarge
              ),
            ),
            Padding( // Foto
              padding: EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 60,
                child: Text(widget.pet.nome.substring(0,1), style: TextStyle(
                  fontSize: 60,
                ),),
              ),
            ),
            SizedBox(height: 20),
            // Dados
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Nome', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.nome, style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Espécie', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.especie, style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Sexo', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.sexo, style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Raça', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.raca, style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Data de nascimento', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.formatarData(), style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Observações', style: TextStyle(fontSize: 20),),
                      subtitle: Text(widget.pet.obs != null ? widget.pet.obs! : 'Sem observações', style: TextStyle(fontSize: 18)),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}