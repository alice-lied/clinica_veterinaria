import 'package:flutter/material.dart';

class PetVisualizarScreen extends StatelessWidget {
  const PetVisualizarScreen({super.key});

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
            Padding( // Foto perfil
              padding: EdgeInsets.all(20.0),
              child: CircleAvatar(
                radius: 60,
                child: Icon(Icons.person, size: 60),
              ),
            ),
            SizedBox(height: 20),
            // Dados do usuário
            Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.pets),
                      title: Text('Nome', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Pipoca', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.question_mark),
                      title: Text('Sexo', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Masculino', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.calendar_month),
                      title: Text('Data de nascimento', style: TextStyle(fontSize: 20),),
                      subtitle: Text('19/06/2018', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.medical_services),
                      title: Text('Observações', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Tomar remédio p/ vermes\nLimpar orelhas 1 vez por semana', style: TextStyle(fontSize: 18)),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implementar lógicas de botões
                debugPrint('editar dados do pet');
              },
              icon: Icon(Icons.edit, color: Colors.black87),
              label: Text('Editar dados', style: TextStyle(fontSize: 18, color: Colors.black87)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
                backgroundColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 10),

            TextButton.icon(
              onPressed: () {
                // TODO: Implementar exclusão de conta
                debugPrint('apagar dados do pet');
              },
              icon: const Icon(Icons.delete, color: Colors.red),
              label: const Text('Apagar dados', style: TextStyle(color: Colors.red, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}