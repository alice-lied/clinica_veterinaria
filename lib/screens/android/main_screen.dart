import 'package:clinica_veterinaria/screens/android/pets/add_pet_screen.dart';
import 'package:clinica_veterinaria/screens/android/pets/editar_pet_screen.dart';
import 'package:clinica_veterinaria/screens/android/pets/visualizar_pet_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/consulta.dart';
import '../../model/pet.dart';
import '../../service/consulta_service.dart';
import '../../service/pet_service.dart';
import 'consulta/add_consulta_screen.dart';
import 'consulta/editar_consulta_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;
  final ConsultaService _consultaService = ConsultaService();
  final PetService _petService = PetService();
  late Future<List<Pet>> _pets;
  late Future<List<Consulta>> _consultas;

  @override
  void initState(){
    super.initState();
    _pets = _petService.listarPets();
    _consultas = _consultaService.listarConsultas();
  }

  void _atualizaPets(){
    setState(() {
      _pets = _petService.listarPets();
    });
  }

  void _atualizaConsultas(){
    setState(() {
      _consultas = _consultaService.listarConsultas();
    });
  }

  void _excluirPet(int? idPet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar exclusão'),
        content: const Text('Tem certeza que deseja excluir os dados?', style: TextStyle(
          fontSize: 17,
        ),),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _petService.excluirPet(idPet);
              _atualizaPets();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Dados excluídos com sucesso!')),
              );
            },
            child: const Text('Excluir', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _desmarcarConsulta(int? idConsulta) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Desmarcar consulta'),
        content: const Text('Tem certeza que deseja desmarcar a consulta?', style: TextStyle(
          fontSize: 17,
        )),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              await _petService.excluirPet(idConsulta);
              _atualizaPets();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Consulta desmarcada com sucesso!')),
              );
            },
            child: const Text('Desmarcar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber[200],
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home, size: 40, color: Colors.teal),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.pets, size: 40, color: Colors.teal),
            label: 'Pets',
          ),
          NavigationDestination(
            icon: Icon(Icons.person, size: 40, color: Colors.teal),
            label: 'Conta',
          ),
        ],
      ),
      body:
      <Widget>[
        /// Página consultas (home)
        Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<Consulta>>(
              future: _consultas,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma consulta marcada.'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final consulta = snapshot.data![index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(DateFormat('dd/MM/yyyy').format(consulta.dia!), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        subtitle: Text('Paciente: ${consulta.nomePet}\nAssunto: ${consulta.assunto}', style: TextStyle(fontSize: 20)),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 35,),
                              onPressed: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditarConsultaScreen(consulta: consulta),
                                  ),
                                );
                                if (updated == true) {
                                  _atualizaConsultas();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.cancel, color: Colors.red, size: 35,),
                              onPressed: () => _desmarcarConsulta(consulta.idConsulta),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: _BotaoAdd(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddConsultaScreen(),
                  ),
                );
                _atualizaConsultas();
              },
          ),
        ),

        /// Página Pets
        Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: FutureBuilder<List<Pet>>(
              future: _pets,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhum pet registrado.'));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final pet = snapshot.data![index];
                    return Card(
                      margin: EdgeInsets.all(8),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: CircleAvatar(radius: 25,
                          backgroundColor: Colors.blue[100],
                          child: Text(pet.nome.substring(0,1), style: TextStyle(
                            fontSize: 30,
                          ),),
                        ),
                        onTap: () => Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => VisualizarPetScreen(pet: pet)
                        )),
                        title: Text(pet.nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                        subtitle: Text("${pet.especie} ${pet.sexo}", style: TextStyle(fontSize: 16),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, size: 35,),
                              onPressed: () async {
                                final updated = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditarPetScreen(pet: pet),
                                  ),
                                );
                                if (updated == true) {
                                  _atualizaPets();
                                }
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red, size: 35,),
                              onPressed: () => _excluirPet(pet.idPet),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: _BotaoAdd(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPetScreen(),
                  ),
                );
                _atualizaPets();
              },
          ),
        ),

        /// Página Conta
        Padding(
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
              const SizedBox(height: 20),
              // Dados do usuário
              const Card(
                elevation: 0,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text('Nome Completo', style: TextStyle(fontSize: 20),),
                        subtitle: Text('Pessoa Sobrenome', style: TextStyle(fontSize: 18)),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('E-mail', style: TextStyle(fontSize: 20),),
                        subtitle: Text('pessoa@email.com', style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _BotaoConta(
                  onPressed: () {
                    debugPrint('editar conta');
                    },
                  icone: Icons.edit,
                  texto: 'Editar dados'),
              const SizedBox(height: 10),
              _BotaoConta(
                  onPressed: () {
                    debugPrint('sair da conta');
                  },
                  icone: Icons.logout,
                  texto: 'Sair da conta'),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: () {
                  debugPrint('exclusão da conta');
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Excluir Conta', style: TextStyle(color: Colors.red, fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(16),
                ),
              ),
            ],
          ),
        ),
      ][currentPageIndex],
    );
  }
}

class _BotaoConta extends StatelessWidget {
  final Function() onPressed;
  final IconData icone;
  final String texto;

  const _BotaoConta({
    required this.onPressed,
    required this.icone,
    required this.texto,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icone, color: Colors.black87),
      label: Text(texto, style: TextStyle(fontSize: 18, color: Colors.black87)),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(16),
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}

class _BotaoAdd extends StatelessWidget {
  final Function() onPressed;

  const _BotaoAdd({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 75,
      height: 75,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: Colors.teal,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}