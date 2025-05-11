import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('À propos de l\'application'),
        elevation: 1,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.apps, size: 50, color: Colors.white),
              ),
            ),
          ),
          const Center(
            child: Text(
              'Mon Application',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.only(top: 8, bottom: 16),
              child: Text('Version 1.0.0'),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Développeur'),
            subtitle: const Text('Développé par MonEntreprise'),
          ),
          ListTile(
            title: const Text('Copyright'),
            subtitle: const Text('© 2025 MonEntreprise. Tous droits réservés'),
          ),
          ListTile(
            title: const Text('Licence'),
            subtitle: const Text('Consulter la licence d\'utilisation'),
            onTap: () {},
          ),
          const Divider(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Text(
              'Crédits',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const ListTile(
            title: Text('Bibliothèques tierces'),
            subtitle: Text('Flutter, Firebase, et autres dépendances open-source'),
          ),
        ],
      ),
    );
  }
}
