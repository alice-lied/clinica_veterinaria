import 'package:clinica_veterinaria/screens/android/consulta/consulta_visualizar_screen.dart';
import 'package:clinica_veterinaria/screens/android/pets/add_pet_screen.dart';
import 'package:clinica_veterinaria/screens/android/pets/pet_visualizar_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Titulo('Consultas'),
                Expanded( //TODO: if com mensagem "não há consultas agendadas. Clique em + para adicionar"
                    child: ListView(
                      children: <Widget>[
                        _ItemConsulta(),
                        _ItemConsulta(),
                        _ItemConsulta()
                      ],
                    )
                ),
              ],
            ),
          ),
          floatingActionButton: _BotaoAdd(
              onPressed: () {
                debugPrint('adicionar consulta');
              }
          ),
        ),

        /// Página Pets
        Scaffold(
          body: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Titulo('Pets'),
                Expanded( //TODO: if com mensagem "não há pets registrados. Clique em + para adicionar"
                    child: ListView(
                      children: [
                        _ItemPet(),
                        _ItemPet(),
                      ],
                    )
                )
              ],
            ),
          ),
          floatingActionButton: _BotaoAdd(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AddPetScreen()
                ));
              }
          ),
        ),

        /// Página Conta
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _Titulo('Conta'),
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
                        subtitle: Text('João da Silva', style: TextStyle(fontSize: 18)),
                      ),
                      Divider(),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Text('E-mail', style: TextStyle(fontSize: 20),),
                        subtitle: Text('joao@email.com', style: TextStyle(fontSize: 18)),
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
                  // TODO: Implementar exclusão de conta
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

class _Titulo extends StatelessWidget {
  final String texto;
  const _Titulo(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 10.0,
      ),
      child: Text(texto,
          style: Theme.of(context).textTheme.headlineLarge
      ),
    );
  }
}

class _ItemPet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PetVisualizarScreen()
        )),
        leading: CircleAvatar(radius: 25, child: Icon(Icons.pets)),
        title: Text('Pipoca', style: TextStyle(fontSize: 22)),
        subtitle: Text('Gato macho', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

class _ItemConsulta extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(10),
        child: ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ConsultaVisualizarScreen()
          )),
          title: Text('Data: 10/10/2025', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          subtitle: Text('Paciente: Pipoca\nAssunto: Vacinação', style: TextStyle(fontSize: 20)),
          isThreeLine: true,
        )
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
