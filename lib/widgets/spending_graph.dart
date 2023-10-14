import 'package:flutter/material.dart';

class SpendingGraph extends CustomPainter {
  final double circleRadius;

  SpendingGraph({required this.circleRadius});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(30, 20) & Size(100, 100);
    Paint paint = Paint();
    paint.color = Colors.white;
    paint.strokeWidth = 50;
    paint.style = PaintingStyle.stroke;
    List<int> list = [100, 50, 20, 90, 260];
    const sweepAngleValue = 6.3;
    double startAngle = 0;
    for (int i = 0; i < list.length; i++) {
      double sweepAngle =
          (sweepAngleValue * getPercentage(list[i], list)) / 100;
      canvas.drawArc(rect, startAngle, sweepAngle, false,
          paint..color = Colors.primaries[i]);
      startAngle += sweepAngle;

      //for points ------------------
      Paint p2 = Paint();
      p2.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(rect.right + paint.strokeWidth, (i + 0.3) * 30),
          8, p2..color = paint.color);
      //for text -------------------
      TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: const TextSpan(
              text: "Shoping",
              style: TextStyle(fontSize: 17, color: Colors.black)));
      textPainter.layout(maxWidth: size.width);
      textPainter.paint(
          canvas, Offset(rect.right + paint.strokeWidth + 20, i * 30));
    }
  }

  double getPercentage(int value, List<int> list) {
    return (value * 100) / list.reduce((value, element) => value + element);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
