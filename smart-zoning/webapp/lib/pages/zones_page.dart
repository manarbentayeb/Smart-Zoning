import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:mobilis/widgets/app_bar.dart'; 

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  void _showDialog(BuildContext context, bool isAdd, Offset position) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0, left: 40.0), 
          child: Container(
            width: 300,
            height: 400,
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

          Expanded(
            child: Stack(
              children: [
                PhotoView(
                  imageProvider: const AssetImage('assets/images/gps_map.png'),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 2.0,
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
                          final position = renderBox.localToGlobal(Offset(10, 30));
                          _showDialog(context, true, position);
                        },
                        backgroundColor: Colors.green,
                        mini: true, // Smaller button
                        child: const Icon(Icons.add, color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      FloatingActionButton(
                        heroTag: 'remove',
                        onPressed: () {
                          final renderBox = context.findRenderObject() as RenderBox;
                          final position = renderBox.localToGlobal(Offset(10, 70));
                          _showDialog(context, false, position);
                        },
                        backgroundColor: Colors.red[200],
                        mini: true, // Smaller button
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
          const Center(
            child: Text(
              'Ajouter un PDV',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(decoration: _fieldDecoration('Nom de PDV')),
          const SizedBox(height: 12),
          TextField(decoration: _fieldDecoration('Commune')),
          const SizedBox(height: 12),
          TextField(decoration: _fieldDecoration('Daira')),
          const SizedBox(height: 12),
          TextField(decoration: _fieldDecoration('Wilaya')),
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
