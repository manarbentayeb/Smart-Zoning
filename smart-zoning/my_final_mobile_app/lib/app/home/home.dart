import 'package:flutter/material.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';
import 'package:myapp/app/Profile/profile.dart';
import 'package:myapp/app/home/LineChartPainter.dart';
import 'package:myapp/app/home/side%20bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PDVListScreen()), 
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Accueil',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        child: SideBar(
          onClose: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              decoration: const BoxDecoration(
                color: Color(0xFFE3F7E3),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'lib/assets/city_skyline.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistiques du Performance:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children:[
                      Text(
                        'Last Week',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '+25.3 (9%)',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFF4CAF50),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomPaint(
                      painter: LineChartPainter(),
                    ),
                  ),
                  const Padding(
                    padding:  EdgeInsets.only(top: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:  [
                        Text('10 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('11 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('12 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('13 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('14 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                        Text('15 Aug', style: TextStyle(fontSize: 10, color: Colors.black54)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Tâches ajoutées:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'nom de pdv',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(221, 89, 172, 73),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'commune/daira/wilaya',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: " ",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: " ",
          ),
        ],
      ),
    );
  }
}


