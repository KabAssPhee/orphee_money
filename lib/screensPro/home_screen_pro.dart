import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orphee_money/data/user_info_pro.dart';
import 'package:orphee_money/widgetPro/income_expense_pro.dart';
import 'package:orphee_money/widgetPro/transaction_item_pro.dart';

import '../utils/constants.dart';

class HomeScreenTabPro extends StatefulWidget {
  const HomeScreenTabPro({super.key});

  @override
  State<HomeScreenTabPro> createState() => _HomeScreenTabProState();
}

class _HomeScreenTabProState extends State<HomeScreenTabPro> {
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userEmail = user.email ?? 'Email non disponible';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultSpacing * 4,
              ),
              Material(
                child: ListTile(
                  title: Text(
                      "Salut!\n${userEmail}, bienvenue sur votre compte profesionnel"),
                  leading: ClipRRect(
                      borderRadius: const BorderRadius.all(
                          Radius.circular(defaultRadius)),
                      child: Image.asset("assets/images/avatar.jpeg")),
                  trailing: Image.asset("assets/icons/bell.png"),
                ),
              ),
              const SizedBox(
                height: defaultSpacing,
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      "${userdatapro.totalBalance}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: fontSizeHeading,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    Text(
                      "Solde Total",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: fontSubHeading),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: defaultSpacing * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: IncomeExpenseCardPro(
                    expenseData: ExpenseDataPro("Revenu",
                        "${userdatapro.inflow}", Icons.arrow_upward_rounded),
                  )),
                  SizedBox(
                    width: defaultSpacing,
                  ),
                  Expanded(
                      child: IncomeExpenseCardPro(
                    expenseData: ExpenseDataPro(
                        "Dépenses",
                        "-${userdatapro.outflow}",
                        Icons.arrow_downward_rounded),
                  )),
                ],
              ),
              const SizedBox(
                height: defaultSpacing * 2,
              ),
              Text(
                "Transactions récentes",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: defaultSpacing,
              ),
              const Text(
                "Aujourd'hui",
                style: TextStyle(color: fontSubHeading),
              ),
              ...userdatapro.transactions.map((transaction) =>
                  TransactionItemTilePro(transactionpro: transaction)),
              const SizedBox(
                height: defaultSpacing,
              ),
              const Text(
                "Hier",
                style: TextStyle(color: fontSubHeading),
              ),
              ...transactionsPro2.map((transaction) =>
                  TransactionItemTilePro(transactionpro: transaction)),
            ],
          ),
        ),
      ),
    );
  }
}
