import 'package:flutter/material.dart';
import 'package:myapp/app/Widgets/MenuItem.dart';
import 'package:myapp/app/Widgets/ProfileMenuItem.dart';
import 'package:myapp/app/ChangerMotDePasse/change%20pass.dart';
import 'package:myapp/app/Identification/login.dart';
import 'package:myapp/app/Profile/modify_profile.dart';
// Importez les pages auxquelles vous voulez naviguer
import 'package:myapp/app/Acceuil/home.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 3; // Index 3 car on est sur la page Profile

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    // Navigation logic based on bottom nav bar selection
    switch (index) {
      case 0:
        // Navigate to Home
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PathGeneratorScreen()), // Votre page Home
        );
        break;
      case 1:
        // Navigate to Devoirs (PDVs)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDVListScreen()), // Votre page Devoirs
        );
        break;
      case 2:
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDVListScreen()), // Votre page Devoirs
        );
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      AssetImage('lib/assets/profile_picture.jpg'),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'mobilis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'mobilis1-01 224 567 89',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Affecté à "Nom du Manager"',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ProfileMenuItem(
                icon: Icons.edit,
                text: 'Éditer le profil, informations',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileEditPage()),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Second Container - Other Options
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  MenuItem(
                    icon: Icons.help_outline,
                    text: 'Aide & Support',
                    onTap: () => null,
                  ),
                  MenuItem(
                    icon: Icons.privacy_tip_outlined,
                    text: 'Privacy policy',
                    onTap: () => null,
                  ),
                  MenuItem(
                    icon: Icons.security,
                    text: 'Politique de confidentialité',
                    onTap: () => null,
                  ),
                  MenuItem(
                    icon: Icons.lock_outline,
                    text: 'Changer le mot de passe',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PasswordChangePage()),
                    ),
                  ),
                  MenuItem(
                    icon: Icons.logout,
                    text: 'Déconnexion',
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            // Add some padding at the bottom to ensure everything is visible
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue, // Pour montrer l'item sélectionné
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on_outlined),
            label: 'Devoirs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: 'Achever',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}