import 'package:flutter/material.dart';
import 'package:myapp/app/Profile/InfoRaw.dart';
import 'package:myapp/app/Profile/MenuItem.dart';
import 'package:myapp/app/ChangerMotDePasse/change%20pass.dart';
import 'package:myapp/app/Identification/login.dart';
import 'package:myapp/app/Profile/modify_profile.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';
import 'package:myapp/app/home/home.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 2; 

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    
    switch (index) {
      case 0:
       
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDVListScreen()), 
        );
        break;
      case 2:
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
              'Mobilis',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'mobilis@gmail.com',
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
              child: const Column(
                children: [
                   InfoRow(label: 'Nom et Prénom', value: 'Mobilis'),
                   Divider(),
                   InfoRow(label: 'Email', value: 'mobilis@gmail.com'),
                   Divider(),
                   InfoRow(label: 'Address', value: 'Bab Ezzouar Alger'),
                   Divider(),
                   InfoRow(label: 'Date of Birth', value: '01/01/1990'),
                   Divider(),
                   InfoRow(label: 'Manager Responsable', value: 'manager'),
                ],
              ),
            ),

            
            const SizedBox(height: 20),
            
           
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
                    icon: Icons.edit,
                    text: 'Editer le profil',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileEditPage()),
                    ),
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
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    ),
                  )
                ]
              ),
            ),
            
           
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue, 
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: ' ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: ' ',
          ),
        ],
      ),
    );
  }
}