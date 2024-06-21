import 'package:flutter/material.dart';
import 'package:orphee_money/screensPro/expense_screen_pro.dart';
import 'package:orphee_money/screensPro/home_profile_pro.dart';
import 'package:orphee_money/screensPro/home_screen_pro.dart';
import 'package:orphee_money/utils/constants.dart';

class MainScreenHostPro extends StatefulWidget {
  const MainScreenHostPro({super.key});

  @override
  State<MainScreenHostPro> createState() => _MainScreenHostProState();
}

class _MainScreenHostProState extends State<MainScreenHostPro> {
  var currentIndex = 0;

  Widget buildTabContent(int index) {
    switch (index) {
      case 0:
        return const HomeScreenTabPro();
      case 1:
        return ExpenseScreenPro();
      case 2:
        return Container();
      case 3:
        return const HomeProfileTabPro();
      default:
        return const HomeScreenTabPro();
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
              icon: Image.asset("assets/icons/home-1.png"), label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/chart-vertical.png"),
              label: "Stat"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/wallet.png"), label: "Wallet"),
          BottomNavigationBarItem(
              icon: Image.asset("assets/icons/user-1.png"), label: "Profile")
        ],
      ),
    );
  }
}
