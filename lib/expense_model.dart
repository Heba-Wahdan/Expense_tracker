import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final dateFormatted = DateFormat.yMd();

enum Categories { leisure, lebensmittel, car, rausessen, travel, work, sport }

const categoryIcons = {
  Categories.lebensmittel: Icons.local_grocery_store,
  Categories.leisure: Icons.sports_esports,
  Categories.travel: Icons.flight_takeoff,
  Categories.work: Icons.work,
  Categories.sport: Icons.fitness_center,
  Categories.rausessen: Icons.lunch_dining,
  Categories.car: Icons.car_crash,
};

const uuid = Uuid();

class ExpenseObjectModel {
  final String title;
  final double amount;
  final Categories category;
  final DateTime date;
  final String id;

  ExpenseObjectModel(
      {required this.title,
      required this.amount,
      required this.category,
      required this.date})
      : id = uuid.v4();

  String get formattedDate {
    return dateFormatted.format(date);
  }
}

class ExpenseBucket {
  final Categories category;
  final List<ExpenseObjectModel> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseObjectModel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) =>
                expense.category ==
                category) // flterha 3la 7sb el category el ana mdyhalek
            .toList();

  double get totalExpenses {
    //total expense for one category
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
