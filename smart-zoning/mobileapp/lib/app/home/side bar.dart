import 'package:flutter/material.dart';
import 'package:myapp/app/Settings/Settings.dart';
import 'package:myapp/app/Acceuil/home.dart';
import 'package:myapp/app/Identification/login.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';
import 'package:myapp/app/Profile/profile.dart';

class SideBar extends StatefulWidget {
  final VoidCallback? onClose;
  
  const SideBar({Key? key, this.onClose}) : super(key: key);
  
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _selectedIndex = 0;
  
  // Assurez-vous que l'ordre correspond à ce que vous attendez
  final List<String> _menuItems = ['Accueil', 'Devoirs', 'Profile', 'Paramètres'];
  
  // Map menu items to their corresponding pages - VÉRIFIEZ CET ORDRE
  final List<Widget> _pages = [
    PathGeneratorScreen(), // index 0 - Accueil
    PDVListScreen(),      // index 1 - Devoirs
    ProfileScreen(),      // index 2 - Profile
    SettingsPage(),       // index 3 - Paramètres
  ];
  
  void _navigateToPage(int index, BuildContext context) {
    // Imprimez l'index pour le débogage si vous utilisez un émulateur
    print('Navigating to index: $index');
    
    setState(() {
      _selectedIndex = index;
    });
    
    // Close the drawer if it's open
    if (widget.onClose != null) {
      widget.onClose!();
    }
    
    // Navigate to the selected page
    Navigator.pushReplacement(  // Utilisez pushReplacement au lieu de push
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: Container(
        width: 250,
        color: Colors.white,
        child: Column(
          children: [
            // En-tête du SideBar
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('lib/assets/profile_picture.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mobilis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            
            // Menu items
            Expanded(
              child: ListView.builder(
                itemCount: _menuItems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: _getIconForIndex(index),
                    title: Text(
                      _menuItems[index],
                      style: TextStyle(
                        color: _selectedIndex == index ? Colors.blue : Colors.black,
                      ),
                    ),
                    onTap: () => _navigateToPage(index, context),
                  );
                },
              ),
            ),
            
            // Item de déconnexion séparé des autres items du menu
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Assurez-vous que cette action est bien distincte des autres actions du menu
                print('Logout button pressed');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Icon _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icon(Icons.home, color: _selectedIndex == 0 ? Colors.blue : Colors.grey);
      case 1:
        return Icon(Icons.assignment, color: _selectedIndex == 1 ? Colors.blue : Colors.grey);
      case 2:
        return Icon(Icons.person, color: _selectedIndex == 2 ? Colors.blue : Colors.grey);
      case 3:
        return Icon(Icons.settings, color: _selectedIndex == 3 ? Colors.blue : Colors.grey);
      default:
        return Icon(Icons.error);
    }
  }
}