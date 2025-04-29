import 'package:flutter/material.dart';
import 'package:myapp/app/Acceuil/home.dart';
import 'package:myapp/app/PDVs/QRCode.dart';
import 'package:myapp/app/Profile/profile.dart';

class PDVListScreen extends StatefulWidget {
  const PDVListScreen({Key? key}) : super(key: key);

  @override
  State<PDVListScreen> createState() => _PDVListScreenState();
}

class _PDVListScreenState extends State<PDVListScreen> {
  int _selectedIndex = 1;
  List<Map<String, dynamic>> pdvList = [
    {'id': '1', 'name': 'nom de pdv', 'location': 'commune/daira/wilaya', 'scanned': false},
    {'id': '2', 'name': 'nom de pdv', 'location': 'commune/daira/wilaya', 'scanned': false},
    {'id': '3', 'name': 'nom de pdv', 'location': 'commune/daira/wilaya', 'scanned': false},
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PathGeneratorScreen()),
        );
        break;
      case 1:
        break;
      case 2:
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PDVListScreen()), // Votre page Devoirs
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List de PDV'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pdvList.length,
        itemBuilder: (context, index) {
          final item = pdvList[index];
          return _buildPdvListItem(item, index);
        },
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
            icon: Icon(Icons.person_outlined),
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _buildPdvListItem(Map<String, dynamic> item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: item['scanned'] 
                  ? const Icon(Icons.check, color: Colors.green, size: 24)
                  : Text(
                      item['id']!,
                      style: const TextStyle(color: Colors.black54),
                    ),
            ),
          ),
        ),
        title: Text(
          item['name']!,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.green,
          ),
        ),
        subtitle: Text(
          item['location']!,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
        trailing: item['scanned']
            ? null // No trailing widget if already scanned
            : GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QRScannerScreen()),
                  );
                  
                  if (result != null && result is bool && result) {
                    setState(() {
                      pdvList[index]['scanned'] = true;
                    });
                  }
                },
                child: Container(
                  width: 100,
                  height: 100,
                  child: const Icon(
                    Icons.qr_code_scanner,
                    color: Colors.black,
                    size: 37,
                  ),
                ),
              ),
      ),
    );
  }
}