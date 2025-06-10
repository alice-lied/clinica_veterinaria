import 'package:clinica_veterinaria/screens/android/login_screen.dart';
import 'package:flutter/material.dart';

class AppClinica extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Patinhas',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginScreen(),
    );
  }
}