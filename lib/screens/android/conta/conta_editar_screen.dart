import 'package:flutter/material.dart';

class ContaEditarScreen extends StatelessWidget {
  const ContaEditarScreen({super.key});

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
              child: Text('Editar dados da conta',
                  style: Theme.of(context).textTheme.headlineLarge
              ),
            ),
          ],
        ),
      ),
    );
  }
}