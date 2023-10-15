import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/model/expense.dart';
import '/provider/expenses_manager.dart';
import '/screens/expense_screen.dart';
import '/widgets/spending_graph.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/screen/home_screen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ExpensesManager expensesManager = context.watch<ExpensesManager>();
    final List<Expense> expenses = expensesManager.expenses;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: expenses.isEmpty
          ? const Center(
              child: Text(
                'No Spending Found',
                style: TextStyle(fontSize: 20),
              ),
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding:
                  EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGraphContainer(expensesManager, expenses),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Spending',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: expenses.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (_, index) => _buildListItem(expenses, index),
                    separatorBuilder: (_, index) {
                      return const SizedBox(height: 10);
                    },
                  )
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, ExpenseScreen.routeName);
        },
      ),
    );
  }

  Widget _buildGraphContainer(
      ExpensesManager expensesManager, List<Expense> expenses) {
    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.grey.shade300, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Spending',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  '\$${expensesManager.totalAmountSpend} ',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
              width: double.infinity,
              child: CustomPaint(
                  painter: SpendingGraph(
                      circleRadius: 100,
                      expenses: expenses,
                      totalSpending: expensesManager.totalAmountSpend))),
        ],
      ),
    );
  }

  Widget _buildListItem(List<Expense> expenses, int index) {
    return ListTile(
      tileColor: Colors.grey.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        expenses[index].title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(expenses[index].category),
      trailing: Text(
        '\$${expenses[index].amount}',
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
      ),
    );
  }
}
