import 'package:expense_tracker/widgets/expensesList/expenses_list.dart';
import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerdExpenses = [
    Expense(
      title: "Flutter Course",
      amount: 450,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Movie",
      amount: 200,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => SizedBox(
        height: 650, // Set the desired height of the modal
        child: NewExpense(
          onAddExpense: _addExpense,
        ),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerdExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerdExpenses.indexOf(expense);

    setState(() {
      _registerdExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Deleted"),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registerdExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = const Center(
      child: Text(
        "No Expense Found...\nStart Adding Some!!",
        style: TextStyle(fontSize: 20),
      ),
    );

    if (_registerdExpenses.isNotEmpty) {
      maincontent = ExpensesList(
        expenses: _registerdExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment:
              Alignment.centerLeft, // Align the title to the start (left)
          child: Text(
            "ExpenseTracker",
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("The Chart"),
          Expanded(
            //to resolve column inside column we again wrap with the expanded
            child: maincontent,
          ),
        ],
      ),
    );
  }
}
