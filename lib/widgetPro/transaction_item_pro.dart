import 'dart:math';

import 'package:flutter/material.dart';
import 'package:orphee_money/data/user_info_pro.dart';
import 'package:orphee_money/utils/constants.dart';

class TransactionItemTilePro extends StatelessWidget {
  final TransactionPro transactionpro;

  const TransactionItemTilePro({super.key, required this.transactionpro});

  @override
  Widget build(BuildContext context) {
    String getSign(TransactionTypePro type) {
      switch (type) {
        case TransactionTypePro.inflow:
          return "+";
        case TransactionTypePro.outflow:
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
            child: transactionpro.categoryTypePro == ItemCategoryTypePro.fashion
                ? const Icon(Icons.supervised_user_circle_sharp)
                : Icon(Icons.house)),
        title: Text(
          transactionpro.itemCategoryNamePro,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: fontHeading, fontSize: fontSizeTitle),
        ),
        subtitle: Text(transactionpro.itemNamePro,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: fontSubHeading,
                fontSize: fontSizeBody,
                fontWeight: FontWeight.w700)),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "${getSign(transactionpro.transactionTypePro)}${transactionpro.amountPro}",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: transactionpro.transactionTypePro ==
                          TransactionTypePro.outflow
                      ? Colors.red
                      : fontHeading,
                  fontSize: fontSizeBody),
            ),
            Text(
              transactionpro.datePro,
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
