import 'package:expense_tracker/expense_card.dart';
import 'package:expense_tracker/expense_model.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpenseObjectModel> expensesList;
  final Function(ExpenseObjectModel expense) onRemoveExpense;

  const ExpensesList(
      {super.key, required this.expensesList, required this.onRemoveExpense});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expensesList.length,
        itemBuilder: (context, index) => Dismissible(
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.9),
              ),
              onDismissed: (direction) {
                onRemoveExpense(expensesList[index]);
              },
              key: ValueKey(expensesList[index]),
              child: ExpenseCard(
                expensesList[index],
              ),
            ));
  }
}
