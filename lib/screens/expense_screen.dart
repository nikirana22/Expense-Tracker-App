import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/model/expense.dart';
import '/provider/expenses_manager.dart';

class ExpenseScreen extends StatefulWidget {
  static const String routeName = '/screen/expense_screen';

  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  static const List _categories = ['Food', 'Transportation', 'Utilities'];
  String _selectedCategory = _categories[0];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Screen'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildTextField(
                  hint: 'Enter Title',
                  controller: _titleController,
                  validator: (value) =>
                      value!.isEmpty ? 'Title can\'t be Empty' : null),
              const SizedBox(height: 30),
              _buildTextField(
                  hint: 'Enter Amount',
                  controller: _amountController,
                  validator: _amountValidator),
              const SizedBox(height: 30),
              DropdownButton<String>(
                  value: _selectedCategory,
                  isExpanded: true,
                  items: List.generate(
                      _categories.length,
                      (index) => DropdownMenuItem<String>(
                          value: _categories[index],
                          child: Text(_categories[index]))),
                  onChanged: _onChanged),
              const SizedBox(height: 30),
              TextButton(
                onPressed: _onSave,
                style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.pink),
                child: const Text(
                  'Save',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onChanged(value) {
    setState(() {
      _selectedCategory = value!;
    });
  }

  Widget _buildTextField(
      {String? hint,
      TextEditingController? controller,
      String? Function(String? value)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      validator: validator,
      decoration:
          InputDecoration(hintText: hint, border: _buildTextFieldBorder()),
    );
  }

  InputBorder _buildTextFieldBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: Colors.black));
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final expense = Expense(_titleController.text,
          double.parse(_amountController.text), _selectedCategory);
      Provider.of<ExpensesManager>(context, listen: false).addExpenses(expense);
      Navigator.pop(context);
    }
  }

  String? _amountValidator(String? value) {
    if (value!.isEmpty) {
      return 'Amount can\'t be Empty';
    } else if (double.tryParse(value) == null) {
      return 'Enter valid Amount';
    } else if (double.parse(value) <= 0) {
      return 'Amount should be more than 0';
    } else if (value.length > 10) {
      return 'Amount is too High';
    }
    return null;
  }
}
