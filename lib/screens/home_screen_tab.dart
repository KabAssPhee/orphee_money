import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orphee_money/data/userInfo.dart';
import 'package:orphee_money/screens/expense_screen.dart';
import 'package:orphee_money/widget/income_expense_card.dart';
import 'package:orphee_money/widget/transaction_item_tile.dart';

import '../utils/constants.dart';

class HomeScreenTab extends StatefulWidget {
  const HomeScreenTab({super.key});

  @override
  State<HomeScreenTab> createState() => _HomeScreenTabState();
}

class _HomeScreenTabState extends State<HomeScreenTab> {
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
                      "Salut!\n${userEmail}, bienvenue sur votre compte personnel"),
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
                      "${userdata.totalBalance}",
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
                      child: IncomeExpenseCard(
                    expenseData: ExpenseData("Revenu", "${userdata.inflow}",
                        Icons.arrow_upward_rounded),
                  )),
                  SizedBox(
                    width: defaultSpacing,
                  ),
                  Expanded(
                      child: IncomeExpenseCard(
                    expenseData: ExpenseData("Dépenses", "-${userdata.outflow}",
                        Icons.arrow_downward_rounded),
                  )),
                ],
              ),
              const SizedBox(
                height: defaultSpacing * 2,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Transactions récentes",
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ExpenseScreen()));
                  },
                  child: Text(
                    'Tout afficher',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: fontDarker, fontWeight: FontWeight.w600),
                  ),
                )
              ]),
              const SizedBox(
                height: defaultSpacing,
              ),
              const Text(
                "Aujourd'hui",
                style: TextStyle(color: fontSubHeading),
              ),
              ...userdata.transactions.map((transaction) =>
                  TransactionItemTile(transaction: transaction)),
              const SizedBox(
                height: defaultSpacing,
              ),
              const Text(
                "Hier",
                style: TextStyle(color: fontSubHeading),
              ),
              ...transactions2.map((transaction) =>
                  TransactionItemTile(transaction: transaction)),
            ],
          ),
        ),
      ),
    );
  }
}
