import 'package:flutter/material.dart';

class ConsultaVisualizarScreen extends StatelessWidget {
  const ConsultaVisualizarScreen({super.key});

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
            child: Text('Dados da consulta',
                style: Theme.of(context).textTheme.headlineLarge
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView(
                  children: [
                    ListTile(
                      title: Text('Nome', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Pipoca', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Sexo', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Masculino', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Raça', style: TextStyle(fontSize: 20),),
                      subtitle: Text('SRD', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Data de nascimento', style: TextStyle(fontSize: 20),),
                      subtitle: Text('19/06/2018', style: TextStyle(fontSize: 18)),
                    ),
                    Divider(),
                    ListTile(
                      title: Text('Observações', style: TextStyle(fontSize: 20),),
                      subtitle: Text('Tomar remédio p/ vermes\nLimpar orelhas 1 vez por semana', style: TextStyle(fontSize: 18)),
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
            ),
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
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancelar consulta', style: TextStyle(color: Colors.red, fontSize: 18)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(16),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}