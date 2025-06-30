import 'package:clinica_veterinaria/screens/android/login_screen.dart';
import 'package:flutter/material.dart';

class AppClinica extends StatelessWidget {
  const AppClinica({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clínica Patinhas',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: LoginScreen(),
    );
  }
}