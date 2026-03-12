import 'package:flutter/material.dart';

class Expense {
  String id;
  String title;
  double amount;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
  });
}

class ExpensesProvider with ChangeNotifier {

  final List<Expense> _expenses = [];

  // READ
  List<Expense> get expenses {
    return _expenses;
  }

  // CREATE
  void addExpense(String title, double amount) {
    final newExpense = Expense(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
    );

    _expenses.add(newExpense);
    notifyListeners();
  }

  // UPDATE (EDIT)
  void updateExpense(String id, String newTitle, double newAmount) {
    int index = _expenses.indexWhere((expense) => expense.id == id);

    if (index != -1) {
      _expenses[index].title = newTitle;
      _expenses[index].amount = newAmount;
      notifyListeners();
    }
  }

  // DELETE
  void deleteExpense(String id) {
    _expenses.removeWhere((expense) => expense.id == id);
    notifyListeners();
  }
}