import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ExpenseData {
  final String label;
  final String amount;
  final IconData icon;

  const ExpenseData(
    this.label,
    this.amount,
    this.icon,
  );
}

class IncomeExpenseCard extends StatelessWidget {
  final ExpenseData expenseData;

  const IncomeExpenseCard({super.key, required this.expenseData});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(defaultSpacing),
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                offset: Offset.zero,
                spreadRadius: 3,
                blurRadius: 12)
          ],
          color: expenseData.label == "Revenu" ? primaryDark : accent,
          borderRadius: const BorderRadius.all(Radius.circular(defaultRadius))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expenseData.label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultSpacing / 3),
                  child: Text(
                    expenseData.amount,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                )
              ],
            ),
          ),
          Icon(expenseData.icon),
        ],
      ),
    );
  }
}
