import 'dart:ui';

import 'package:flutter/material.dart';


// Custom painter to draw the dotted route line
class RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
      
    // Create a dotted path
    final Path path = Path();
    path.moveTo(90, 115);  // Start point (near A marker)
    path.quadraticBezierTo(
      size.width / 2, 
      size.height / 2 - 20, 
      size.width - 95, 
      size.height - 105,  // End point (near B marker)
    );
    
    // Draw the dotted path
    final dashWidth = 10.0;
    final dashSpace = 5.0;
    double distance = 0.0;
    final PathMetrics pathMetrics = path.computeMetrics();
    
    for (PathMetric pathMetric in pathMetrics) {
      while (distance < pathMetric.length) {
        final double next = distance + dashWidth;
        if (next < pathMetric.length) {
          canvas.drawPath(
            pathMetric.extractPath(distance, next), 
            paint,
          );
        } else {
          canvas.drawPath(
            pathMetric.extractPath(distance, pathMetric.length), 
            paint,
          );
        }
        distance = next + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}