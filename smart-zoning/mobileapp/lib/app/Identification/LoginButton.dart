import 'package:flutter/material.dart';
import 'package:myapp/app/Acceuil/home.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  
  const LoginButton({
    Key? key,
    required this.formKey, required formkey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // Only navigate if the form is valid
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PathGeneratorScreen()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        "s'inscrire",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}