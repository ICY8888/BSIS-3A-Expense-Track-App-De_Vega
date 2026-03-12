import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/expenses_providers.dart';
import 'screens/expense_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExpensesProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExpenseScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}