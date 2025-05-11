import 'package:flutter/material.dart';
import 'package:myapp/app/Settings/Settings.dart';
import 'package:myapp/app/Identification/login.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';
import 'package:myapp/app/Profile/profile.dart';
import 'package:myapp/app/home/home.dart';

class SideBar extends StatefulWidget {
  final VoidCallback? onClose;
  
  const SideBar({Key? key, this.onClose}) : super(key: key);
  
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  int _selectedIndex = 0;
  
  
  final List<String> _menuItems = ['Accueil', 'Devoirs', 'Profile', 'Paramètres'];
  
  
  final List<Widget> _pages = [
    const HomePage(), // index 0 - Accueil
    const PDVListScreen(),      // index 1 - Devoirs
    const ProfileScreen(),      // index 2 - Profile
    const SettingsPage(),       // index 3 - Paramètres
  ];
  
  void _navigateToPage(int index, BuildContext context) {
  
    print('Navigating to index: $index');
    
    setState(() {
      _selectedIndex = index;
    });
    
   
    if (widget.onClose != null) {
      widget.onClose!();
    }
    
   
    Navigator.pushReplacement(  
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
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('lib/assets/profile_picture.jpg'),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mobilis',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            
         
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
            
           
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Déconnexion', style: TextStyle(color: Colors.red)),
              onTap: () {
              
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
        return const Icon(Icons.error);
    }
  }
}