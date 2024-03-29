import 'package:expense_tracker/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Text(
                expense.title,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(), //this is used to take all the space in between two widgets just like a sized box
                  Row(
                    children: [
                      Icon(categoryIcon[expense.category]),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(expense.formattedDate),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
