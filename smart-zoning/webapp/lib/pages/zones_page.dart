import 'package:flutter/material.dart';
import 'package:mobilis/widgets/app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _showInput = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _showInput = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog(BuildContext context, bool isAdd, Offset position) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
          child: Container(
            width: 380,
            height: 370,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10)
              ],
            ),
            child: PDVDialog(isAdd: isAdd),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const CustomAppBar(currentPage: 'zones'),
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Entrer le nombre des représentants',
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  options: MapOptions(
                    center: LatLng(36.75, 3.05), 
                    zoom: 12.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c'],
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 10,
                  child: Column(
                    children: [
                      FloatingActionButton(
                        heroTag: 'add',
                        onPressed: () {
                          final renderBox = context.findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(const Offset(10, 30));
                          _showDialog(context, true, position);
                        },
                        backgroundColor: Colors.green,
                        mini: true,
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: 'remove',
                        onPressed: () {
                          final renderBox = context.findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(const Offset(10, 70));
                          _showDialog(context, false, position);
                        },
                        backgroundColor: Colors.red[200],
                        mini: true,
                        child: const Icon(Icons.remove, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PDVDialog extends StatelessWidget {
  final bool isAdd;
  const PDVDialog({super.key, required this.isAdd});

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Text(
              isAdd ? 'Ajouter un PDV' : 'Supprimer un PDV',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    TextField(decoration: _fieldDecoration('Nom de PDV')),
                    const SizedBox(height: 12),
                    TextField(decoration: _fieldDecoration('Daira')),
                    const SizedBox(height: 12),
                    TextField(decoration: _fieldDecoration('Latitude')),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    TextField(decoration: _fieldDecoration('Commune')),
                    const SizedBox(height: 12),
                    TextField(decoration: _fieldDecoration('Wilaya')),
                    const SizedBox(height: 12),
                    TextField(decoration: _fieldDecoration('Longitude')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isAdd ? Colors.green[300] : Colors.red[300],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              isAdd ? 'Ajouter' : 'Supprimer',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
