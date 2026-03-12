import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expenses_providers.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final amountController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E7D32),
        title: const Text(
          "Expense Tracker",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [

            // TITLE INPUT
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // AMOUNT INPUT
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ADD BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF43A047),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  final title = titleController.text;
                  final amount = double.tryParse(amountController.text) ?? 0;

                  Provider.of<ExpensesProvider>(context, listen: false)
                      .addExpense(title, amount);

                  titleController.clear();
                  amountController.clear();
                },
                child: const Text("Add Expense"),
              ),
            ),

            const SizedBox(height: 10),

            // EXPENSE LIST
            Expanded(
              child: Consumer<ExpensesProvider>(
                builder: (context, provider, child) {

                  if (provider.expenses.isEmpty) {
                    return const Center(
                      child: Text(
                        "No expenses yet",
                        style: TextStyle(fontSize: 16),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: provider.expenses.length,
                    itemBuilder: (context, index) {

                      final expense = provider.expenses[index];

                      return Card(
                        color: Colors.white,
                        elevation: 2,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 5),
                        child: ListTile(
                          title: Text(
                            expense.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "₱${expense.amount}",
                            style: const TextStyle(
                                color: Colors.green),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              // EDIT BUTTON
                              IconButton(
                                icon: const Icon(Icons.edit,
                                    color: Colors.green),
                                onPressed: () {

                                  titleController.text = expense.title;
                                  amountController.text =
                                      expense.amount.toString();

                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title:
                                            const Text("Edit Expense"),
                                        content: Column(
                                          mainAxisSize:
                                              MainAxisSize.min,
                                          children: [

                                            TextField(
                                              controller:
                                                  titleController,
                                              decoration:
                                                  const InputDecoration(
                                                      labelText:
                                                          "Title"),
                                            ),

                                            TextField(
                                              controller:
                                                  amountController,
                                              keyboardType:
                                                  TextInputType
                                                      .number,
                                              decoration:
                                                  const InputDecoration(
                                                      labelText:
                                                          "Amount"),
                                            ),
                                          ],
                                        ),
                                        actions: [

                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(
                                                  context);
                                            },
                                            child:
                                                const Text("Cancel"),
                                          ),

                                          ElevatedButton(
                                            style: ElevatedButton
                                                .styleFrom(
                                              backgroundColor:
                                                  const Color(
                                                      0xFF43A047),
                                            ),
                                            onPressed: () {

                                              final newTitle =
                                                  titleController
                                                      .text;
                                              final newAmount =
                                                  double.tryParse(
                                                          amountController
                                                              .text) ??
                                                      0;

                                              Provider.of<
                                                          ExpensesProvider>(
                                                      context,
                                                      listen:
                                                          false)
                                                  .updateExpense(
                                                      expense.id,
                                                      newTitle,
                                                      newAmount);

                                              Navigator.pop(
                                                  context);
                                            },
                                            child:
                                                const Text("Save"),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),

                              // DELETE BUTTON
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Colors.red),
                                onPressed: () {
                                  provider
                                      .deleteExpense(expense.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}