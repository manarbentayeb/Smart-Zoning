import 'package:flutter/material.dart';
import 'package:mobilis/widgets/app_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool showInput = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    // Start animation when entering page
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        showInput = true;
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
                    center: LatLng(36.75, 3.05), // Algiers
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

class PDVDialog extends StatefulWidget {
  final bool isAdd;
  const PDVDialog({super.key, required this.isAdd});

  @override
  _PDVDialogState createState() => _PDVDialogState();
}

class _PDVDialogState extends State<PDVDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController communeController = TextEditingController();
  final TextEditingController dairaController = TextEditingController();
  final TextEditingController wilayaController = TextEditingController();
  final TextEditingController latitudeController = TextEditingController();
  final TextEditingController longitudeController = TextEditingController();

  Future<void> _handleAction(BuildContext context) async {
    final name = nameController.text;
    final commune = communeController.text;
    final daira = dairaController.text;
    final wilaya = wilayaController.text;
    final latitude = double.tryParse(latitudeController.text) ?? 0.0;
    final longitude = double.tryParse(longitudeController.text) ?? 0.0;

    final url = Uri.parse('http://localhost:50206/'); // Update with your Flask backend URL

    try {
      final response = widget.isAdd
          ? await http.post(url,
              headers: {'Content-Type': 'application/json'},
              body: json.encode({
                'name': name,
                'commune': commune,
                'daira': daira,
                'wilaya': wilaya,
                'latitude': latitude,
                'longitude': longitude,
                'id_zone': 1, // Replace with actual value
                'state': 'active', // Optional
                'order': 1, // Optional
                'id_subzone': 1, // Replace with actual value
              }))
          : await http.delete(Uri.parse('http://localhost:5000/pdv/1')); // Replace with actual ID of PDV

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('PDV ${widget.isAdd ? 'added' : 'deleted'} successfully')));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.body}')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

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
              widget.isAdd ? 'Ajouter un PDV' : 'Supprimer un PDV',
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
                    TextField(controller: nameController, decoration: _fieldDecoration('Nom de PDV')),
                    const SizedBox(height: 12),
                    TextField(controller: dairaController, decoration: _fieldDecoration('Daira')),
                    const SizedBox(height: 12),
                    TextField(controller: latitudeController, decoration: _fieldDecoration('Latitude')),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  children: [
                    TextField(controller: communeController, decoration: _fieldDecoration('Commune')),
                    const SizedBox(height: 12),
                    TextField(controller: wilayaController, decoration: _fieldDecoration('Wilaya')),
                    const SizedBox(height: 12),
                    TextField(controller: longitudeController, decoration: _fieldDecoration('Longitude')),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.isAdd ? Colors.green[300] : Colors.red[300],
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => _handleAction(context),
            child: Text(
              widget.isAdd ? 'Ajouter' : 'Supprimer',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
