// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    
    final fillPaint = Paint()
      ..color = const Color(0xFF4CAF50).withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    final points = [
      Offset(0, size.height * 0.5),
      Offset(size.width * 0.2, size.height * 0.2),
      Offset(size.width * 0.4, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.7),
      Offset(size.width, size.height * 0.3),
    ];
    
    final linePath = Path();
    linePath.moveTo(points[0].dx, points[0].dy);
    
    for (int i = 1; i < points.length; i++) {
      final p0 = i > 0 ? points[i - 1] : points[0];
      final p1 = points[i];
      
      final controlPoint1 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p0.dy);
      final controlPoint2 = Offset(p0.dx + (p1.dx - p0.dx) / 2, p1.dy);
      
      linePath.cubicTo(
        controlPoint1.dx, controlPoint1.dy,
        controlPoint2.dx, controlPoint2.dy,
        p1.dx, p1.dy,
      );
    }
    
    canvas.drawPath(linePath, linePaint);
    
    final fillPath = Path.from(linePath);
    fillPath.lineTo(size.width, size.height);
    fillPath.lineTo(0, size.height);
    fillPath.close();
    
    canvas.drawPath(fillPath, fillPaint);
    
    final dotPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    
    canvas.drawCircle(points[3], 5, dotPaint);
    canvas.drawCircle(points[3], 5, borderPaint);
    
    const textStyle = TextStyle(
      color: Colors.black54,
      fontSize: 12,
    );
    final textSpan =  TextSpan(
      text: '13',
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(points[3].dx + 10, points[3].dy - 20));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}