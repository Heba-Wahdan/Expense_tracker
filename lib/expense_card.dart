import 'package:expense_tracker/expense_model.dart';
import 'package:expense_tracker/main.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseObjectModel expense;

  const ExpenseCard(this.expense, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = MediaQuery.of(context) == Brightness.dark;
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "€${expense.amount.toStringAsFixed(2)}",
                    style: TextStyle(
                        color: isDarkMode
                            ? kDarkColorScheme.primaryContainer
                            : kColorScheme.onSecondaryContainer),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(expense.formattedDate)
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
