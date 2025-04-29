import 'package:flutter/material.dart';
import 'package:myapp/app/PDVs/list%20de%20pdv.dart';
import 'package:myapp/app/Acceuil/side%20bar.dart';

class PathGeneratorScreen extends StatefulWidget {
  const PathGeneratorScreen({Key? key}) : super(key: key);

  @override
  State<PathGeneratorScreen> createState() => _PathGeneratorScreenState();
}

class _PathGeneratorScreenState extends State<PathGeneratorScreen> {
  bool _showSidebar = false;

  void toggleSidebar() {
    setState(() {
      _showSidebar = !_showSidebar;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF8FE1A0),
                  border: Border.all(color: Colors.blue.shade300, width: 2),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu, color: Colors.white),
                          onPressed: toggleSidebar,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        const Text(
                          'Route Planner',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Bienvenu dans\nvotre Générateur\nde Chemin\nIntelligent',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PDVListScreen()),
                        );
                      },
                      icon: const Text(
                        'Voir le chemin',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      label: const Icon(Icons.arrow_forward),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Map Area
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('lib/assets/home.png'),
                      fit: BoxFit.fitHeight ,
                       // Shows full image without zooming
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Sidebar Overlay
          if (_showSidebar)
            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              width: 250,
              child: SideBar(onClose: toggleSidebar),
            ),

          if (_showSidebar)
            Positioned.fill(
              child: GestureDetector(
                onTap: toggleSidebar,
                child: Container(
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
