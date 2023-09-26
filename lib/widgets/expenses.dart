import 'dart:math';

import 'package:expense_tracker_app/models/expense.dart';
import 'package:expense_tracker_app/widgets/chart/chart.dart';
import 'package:expense_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  void _openAddExpenseSheet() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return NewExpense(
          onAddExpense: (Expense expense) {
            _addExpense(expense);
          },
        );
      },
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: const Color.fromARGB(255, 211, 186, 252),
      duration: const Duration(seconds: 3),
      content: const Text(
        'Dépenses supprimer!',
        style: TextStyle(color: Colors.black),
      ),
      action: SnackBarAction(
          textColor: Colors.black,
          label: 'Annuler',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text(
        'Pas de dépenses de trouver. \nCommencer par en ajouter une!',
        textAlign: TextAlign.center,
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 186, 252),
        title: const Text(
          'Suivi de dépenses',
        ),
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(
                  expenses: _registeredExpenses,
                ),
                Expanded(
                  child: mainContent,
                ),
              ],
            )
          : SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: Chart(
                      expenses: _registeredExpenses,
                    ),
                  ),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 211, 186, 252),
        onPressed: _openAddExpenseSheet,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
