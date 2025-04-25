import 'package:flutter/material.dart';
import 'package:myapp/app/Acceuil/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:   PathGeneratorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
