import 'package:flutter/material.dart';
import '/model/expense.dart';

class ExpensesManager extends ChangeNotifier {
  final List<Expense> _expenses = [];
  double totalAmountSpend = 0;

  List<Expense> get expenses => [..._expenses];

  void addExpenses(Expense expense) {
    _expenses.add(expense);
    totalAmountSpend += expense.amount;
    notifyListeners();
  }
}
