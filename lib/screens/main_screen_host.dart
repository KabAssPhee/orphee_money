import 'package:flutter/material.dart';
import 'package:orphee_money/screens/expense_screen.dart';
import 'package:orphee_money/screens/home_profile_tab.dart';
import 'package:orphee_money/screens/home_screen_tab.dart';
import 'package:orphee_money/screens/table_screen.dart';
import 'package:orphee_money/utils/constants.dart';

class MainScreenHost extends StatefulWidget {
  const MainScreenHost({super.key});

  @override
  State<MainScreenHost> createState() => _MainScreenHostState();
}

class _MainScreenHostState extends State<MainScreenHost> {
  var currentIndex = 0;

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeScreenTab();
      case 1:
        return ExpenseScreen();
      case 2:
        return BudgetTable();
      case 3:
        return const HomeProfileTab();
      default:
        return const HomeScreenTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildTabContent(currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: secondaryDark,
        unselectedItemColor: fontLight,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/home-1.png"), label: "Accueil"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/chart-vertical.png"),
              label: "Transaction"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/wallet.png"), label: "Budget"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/user-1.png"), label: "Profile")
        ],
      ),
    );
  }
}
