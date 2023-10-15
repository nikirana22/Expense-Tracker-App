import '/provider/expenses_manager.dart';
import '/screens/expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/home_screen.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => ExpensesManager(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker App',
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        ExpenseScreen.routeName: (_) => const ExpenseScreen(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
