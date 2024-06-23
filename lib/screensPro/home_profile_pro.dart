import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:orphee_money/screens/login_screen.dart';
import 'package:orphee_money/screens/main_screen_host.dart';
import 'package:orphee_money/widgetPro/profile_account_pro.dart';
import '../utils/constants.dart';

class HomeProfileTabPro extends StatefulWidget {
  const HomeProfileTabPro({super.key});

  @override
  State<HomeProfileTabPro> createState() => _HomeProfileTabProState();
}

class _HomeProfileTabProState extends State<HomeProfileTabPro> {
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
      appBar: AppBar(
          elevation: 0,
          backgroundColor: background,
          leading: const Icon(Icons.arrow_back_ios, color: fontSubHeading),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: defaultSpacing),
              child: Icon(Icons.settings),
            ),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultSpacing),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: defaultSpacing,
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(
                              Radius.circular(defaultRadius)),
                          child: Image.asset(
                            "assets/images/avatar.jpeg",
                            width: 95,
                          ),
                        ),
                        // Text(
                        //   "Orphée Kablan",
                        //   style: Theme.of(context)
                        //       .textTheme
                        //       .headlineSmall
                        //       ?.copyWith(
                        //           fontWeight: FontWeight.w700,
                        //           color: fontHeading),
                        // ),
                        Text(
                          "$userEmail",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  color: fontHeading,
                                  fontWeight: FontWeight.w700),
                        ),
                        const Chip(
                          backgroundColor: primaryLight,
                          label: Text("Modifier Profile"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: defaultSpacing),
                          child: Text(
                            "Général",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: fontHeading),
                          ),
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        const GeneralAccountInfoTilePro(
                            title: "Angré 22ème",
                            subTitle: "Rue, I42 Abidjan",
                            imageUrl: "assets/icons/location-1.png"),
                        const GeneralAccountInfoTilePro(
                            title: "Mon portefeuille",
                            subTitle: "Gérer votre portefeuille sauvegardé",
                            imageUrl: "assets/icons/wallet.png"),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: defaultSpacing),
                          child: Text(
                            "Compte",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: fontHeading),
                          ),
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        const ProfileAccountInfoTilePro(
                          iconUrl: "assets/icons/user-1.png",
                          heading: "Mon Compte",
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        const ProfileAccountInfoTilePro(
                          iconUrl: "assets/icons/bell.png",
                          heading: "Notifications",
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        const ProfileAccountInfoTilePro(
                          iconUrl: "assets/icons/lock-on.png",
                          heading: "Confidentialité",
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        const ProfileAccountInfoTilePro(
                          iconUrl: "assets/icons/info-circle.png",
                          heading: "À Propos",
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: defaultSpacing + 10),
                              child: Image.asset("assets/icons/logout.png"),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultSpacing),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MainScreenHost()));
                                  },
                                  child: Text("Compte Personnel",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: fontHeading)),
                                )),
                            const Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: defaultSpacing),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: fontSubHeading,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: defaultSpacing,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: defaultSpacing + 10),
                              child: Image.asset("assets/icons/logout.png"),
                            ),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: defaultSpacing),
                                child: TextButton(
                                  onPressed: () => _signOut(context),
                                  child: Text("Déconnexion",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(color: fontHeading)),
                                )),
                            const Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(right: defaultSpacing),
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: fontSubHeading,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }
}
