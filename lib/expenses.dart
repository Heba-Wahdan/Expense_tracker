import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_list.dart';
import 'package:expense_tracker/expense_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  // ignore: non_constant_identifier_names

  void _AddExpenseOverlay(isDarkMode) {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      backgroundColor:
          isDarkMode ? const Color.fromARGB(255, 56, 37, 60) : Colors.white,
      context: context,
      builder: (ctx) {
        return NewExpense(
          onAddExpense: addExpense,
        );
      },
    );
  }

  final List<ExpenseObjectModel> _enteredExpenses = [
    ExpenseObjectModel(
        title: "food",
        amount: 33,
        category: Categories.lebensmittel,
        date: DateTime.now()),
    ExpenseObjectModel(
        title: "Berlin",
        amount: 77,
        category: Categories.travel,
        date: DateTime.now()),
    ExpenseObjectModel(
        title: "car",
        amount: 100,
        category: Categories.car,
        date: DateTime.now()),
    ExpenseObjectModel(
        title: "moza",
        amount: 50,
        category: Categories.rausessen,
        date: DateTime.now()),
    ExpenseObjectModel(
        title: "tal",
        amount: 26,
        category: Categories.leisure,
        date: DateTime.now()),
    ExpenseObjectModel(
        title: "ebo",
        amount: 35,
        category: Categories.sport,
        date: DateTime.now()),
  ];

  void addExpense(ExpenseObjectModel expense) {
    setState(() {
      _enteredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseObjectModel expense) {
    final removedExpenseIndex = _enteredExpenses.indexOf(expense);
    setState(() {
      _enteredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Removed"),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _enteredExpenses.insert(removedExpenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    Widget mainContent = Center(
      child: Text(
        "No Expenses found. Start adding some!",
        style: TextStyle(
          color: isDarkMode ? Colors.white : kColorScheme.onSecondaryContainer,
        ),
      ),
    );

    if (_enteredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _enteredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
              onPressed: () {
                _AddExpenseOverlay(isDarkMode);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: width < 500
          ? Column(
              children: [
                Chart(expenses: _enteredExpenses),
                Expanded(
                  child: mainContent,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _enteredExpenses)),
                Expanded(
                  child: mainContent,
                )
              ],
            ),
    );
  }
}
