import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Singleton
  static final ThemeProvider _instance = ThemeProvider._internal();
  factory ThemeProvider() => _instance;
  ThemeProvider._internal();
  
  // Propriétés du thème
  bool _isDarkMode = false;
  int _themeColorIndex = 0;
  
  // Getters
  bool get isDarkMode => _isDarkMode;
  int get themeColorIndex => _themeColorIndex;
  
  // Liste des couleurs de thème disponibles
  final List<Color> themeColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
  ];
  
  // Obtenez la couleur actuelle
  Color get currentThemeColor => themeColors[_themeColorIndex];
  
  // Basculer le mode sombre
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
  
  // Changer la couleur du thème
  void setThemeColor(int index) {
    if (index >= 0 && index < themeColors.length) {
      _themeColorIndex = index;
      notifyListeners();
    }
  }
  
  // Obtenir le thème complet
  ThemeData getTheme() {
    return _isDarkMode 
      ? _getDarkTheme(currentThemeColor)
      : _getLightTheme(currentThemeColor);
  }
  
  // Thème clair
  ThemeData _getLightTheme(Color primaryColor) {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      primarySwatch: _getMaterialColorFromColor(primaryColor),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
    );
  }
  
  // Thème sombre
  ThemeData _getDarkTheme(Color primaryColor) {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: primaryColor,
      primarySwatch: _getMaterialColorFromColor(primaryColor),
      scaffoldBackgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[850],
        foregroundColor: Colors.white,
      ),
    );
  }
  
  // Convertir une couleur en MaterialColor
  MaterialColor _getMaterialColorFromColor(Color color) {
    final int r = color.red;
    final int g = color.green;
    final int b = color.blue;
    
    Map<int, Color> shades = {
      50: Color.fromRGBO(r, g, b, .1),
      100: Color.fromRGBO(r, g, b, .2),
      200: Color.fromRGBO(r, g, b, .3),
      300: Color.fromRGBO(r, g, b, .4),
      400: Color.fromRGBO(r, g, b, .5),
      500: Color.fromRGBO(r, g, b, .6),
      600: Color.fromRGBO(r, g, b, .7),
      700: Color.fromRGBO(r, g, b, .8),
      800: Color.fromRGBO(r, g, b, .9),
      900: Color.fromRGBO(r, g, b, 1),
    };
    
    return MaterialColor(color.value, shades);
  }
}