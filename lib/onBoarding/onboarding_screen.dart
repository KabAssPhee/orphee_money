import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:orphee_money/screens/main_screen_host.dart';
import 'package:orphee_money/screensPro/main_screen_pro.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      PageViewModel(
        title: "Ecran 1",
        body: "C'est l'écran 1",
        image: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainScreenHost()));
            },
            child: Image.asset('assets/images/img.png')),
      ),
      PageViewModel(
          title: "Ecran 2",
          body: "C'est l'écran 2",
          image: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainScreenHostPro()));
              },
              child: Image.asset('assets/images/img_1.png'))),
    ];
    return Scaffold(
      body: IntroductionScreen(
        pages: pages,
        showBackButton: true,
        skip: const Text(''),
        next: const Text(''),
        done: const Text(''),
        onDone: () {},
        backStyle: ButtonStyle(),
      ),
    );
  }
}
