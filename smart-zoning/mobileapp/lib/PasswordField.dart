import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final Color fieldColor;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.label,
    required this.isVisible,
    required this.toggleVisibility,
    this.fieldColor = const Color(0xFF2DB34B), // Your specified color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: fieldColor.withOpacity(0.1), // Light green background
        labelText: label,
        labelStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[600],
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: fieldColor),
        ),
        contentPadding: EdgeInsets.all(12),
      ),
    );
  }
}