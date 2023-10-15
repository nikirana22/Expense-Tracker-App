import '/model/expense.dart';
import 'package:flutter/material.dart';

class SpendingGraph extends CustomPainter {
  final double circleRadius;
  final List<Expense> expenses;
  final double strokeWidth;
  final double totalSpending;

  //_sweepAngleValue is 6.3 because our full circle can be formed from 0 to 6.3
  static const double _sweepAngleValue = 6.3;

  SpendingGraph({
    required this.circleRadius,
    required this.expenses,
    this.strokeWidth = 50,
    required this.totalSpending,
  });

  @override
  void paint(Canvas canvas, Size size) {
    /// offset is 20,20 because of padding
    final rect = const Offset(20, 20) & Size(circleRadius, circleRadius);
    Set<String> categories = expenses.map((e) => e.category).toSet();
    Paint paint = Paint();
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = strokeWidth;
    double startAngle = 0;
    for (int i = 0; i < categories.length; i++) {
      double amount = _getCategorySpentAmount(categories.elementAt(i));
      double sweepAngle = (_sweepAngleValue * _getCategoryPer(amount)) / 100;

      /// for graph
      canvas.drawArc(rect, startAngle, sweepAngle, false,
          paint..color = Colors.primaries[i]);
      startAngle += sweepAngle;

      ///for dots ------------------
      Paint p2 = Paint();
      p2.style = PaintingStyle.fill;
      double verticalPos = i * 30;

      canvas.drawCircle(Offset(rect.right + strokeWidth, verticalPos + 10), 8,
          p2..color = paint.color);

      ///for category name -------------------
      TextPainter textPainter = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
              text: categories.elementAt(i),
              style: const TextStyle(fontSize: 17, color: Colors.black)));
      textPainter.layout(maxWidth: size.width);
      textPainter.paint(canvas..getDestinationClipBounds(),
          Offset(rect.right + paint.strokeWidth + 15, verticalPos));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

  double _getCategoryPer(double amount) {
    return (amount * 100) / totalSpending;
  }

  double _getCategorySpentAmount(String category) {
    return expenses
        .where((element) => element.category == category)
        .map((e) => e.amount)
        .reduce((value, element) => value + element);
  }
}
