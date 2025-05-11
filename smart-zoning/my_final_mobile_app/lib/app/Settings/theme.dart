import 'package:flutter/material.dart';
import 'package:myapp/app/Settings/themeProvider.dart';
// Page de sélection du thème
class ThemePage extends StatefulWidget {
  const ThemePage({Key? key}) : super(key: key);

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final ThemeProvider _themeProvider = ThemeProvider();
  
  // Noms des thèmes
  final List<String> _themeNames = ['Bleu', 'Rouge', 'Vert'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thème'),
        elevation: 1,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 20),
          
          // Introduction
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Choisissez votre thème préféré',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          
          // Options de thème
          for (int i = 0; i < _themeProvider.themeColors.length; i++)
            _buildThemeOption(i),
        ],
      ),
    );
  }
  
  Widget _buildThemeOption(int index) {
    final bool isSelected = _themeProvider.themeColorIndex == index;
    final Color themeColor = _themeProvider.themeColors[index];
    
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: themeColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.white : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: themeColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 4,
            )
          ] : null,
        ),
      ),
      title: Text(_themeNames[index]),
      trailing: isSelected ? Icon(Icons.check_circle, color: themeColor) : null,
      onTap: () {
        setState(() {
          _themeProvider.setThemeColor(index);
        });
      },
    );
  }
}
