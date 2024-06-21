import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orphee_money/utils/constants.dart';


import '../data/userInfo.dart';

class TransactionItemTile extends StatelessWidget {
  final Transaction transaction;

  const TransactionItemTile({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    String getSign(TransactionType type) {
      switch (type) {
        case TransactionType.inflow:
          return "+";
        case TransactionType.outflow:
          return "-";
      }
    }

    Color getRandomBgColor() {
      return Color(Random().nextInt(0XFF000000));
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: defaultSpacing / 2),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset.zero,
                blurRadius: 10,
                spreadRadius: 4)
          ],
          color: background,
          borderRadius: BorderRadius.all(Radius.circular(defaultRadius))),
      child: ListTile(
        leading: Container(
            padding: const EdgeInsets.all(defaultSpacing / 2),
            decoration: BoxDecoration(
                color: getRandomBgColor(),
                borderRadius:
                    const BorderRadius.all(Radius.circular(defaultRadius / 2))),
            child: transaction.categoryType == ItemCategoryType.fashion
                ? const Icon(Icons.supervised_user_circle_sharp)
                : Icon(Icons.house)),
        title: Text(
          transaction.itemCategoryName,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: fontHeading, fontSize: fontSizeTitle),
        ),
        subtitle: Text(transaction.itemName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: fontSubHeading,
                fontSize: fontSizeBody,
                fontWeight: FontWeight.w700)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${getSign(transaction.transactionType)}${transaction.amount}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: transaction.transactionType == TransactionType.outflow
                      ? Colors.red
                      : fontHeading,
                  fontSize: fontSizeBody),
            ),
            Text(
              transaction.date,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: fontSubHeading,
                    fontSize: fontSizeBody,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
