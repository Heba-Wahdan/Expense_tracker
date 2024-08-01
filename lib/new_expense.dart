// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:expense_tracker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:expense_tracker/expense_model.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseObjectModel expense) onAddExpense;

  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Categories _selectedCategory = Categories.leisure;
  DateTime? _selectedDate;

  void _datePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void showDialoug() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: ((ctx) => CupertinoAlertDialog(
                title: const Text("Invalid Input"),
                content: const Text(
                    "Please check entered Title, Amount, Category and Date"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text(
                      "Okay",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )));
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
              "Please check entered Title, Amount, Category and Date"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text("Okay"),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _selectedDate == null) {
      showDialoug();
      return;
    }
    widget.onAddExpense(
      ExpenseObjectModel(
        title: _titleController.text,
        amount: enteredAmount,
        category: _selectedCategory,
        date: _selectedDate!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyBoardSpace = MediaQuery.of(context).viewInsets.bottom;
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 48, 16, keyBoardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: InputDecoration(
                  label: Text(
                    "Title",
                    style: TextStyle(
                      color: isDarkMode
                          ? Colors.white
                          : kColorScheme.onSecondaryContainer,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text(
                          "Amount",
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : kColorScheme.onSecondaryContainer,
                          ),
                        ),
                        prefixText: "€",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "No Date Selected"
                              : dateFormatted.format(_selectedDate!),
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : kColorScheme.onSecondaryContainer,
                          ),
                        ),
                        IconButton(
                          onPressed: _datePicker,
                          icon: Icon(
                            Icons.calendar_month,
                            color: isDarkMode
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Categories.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.white
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  const Spacer(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            color: isDarkMode
                                ? Colors.white
                                : Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: const Text("Save Expense"))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
