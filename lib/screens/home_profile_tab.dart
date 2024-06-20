import 'package:flutter/material.dart';
import 'package:phixlab_money/widget/profile_account_info_tile.dart';

import '../utils/constants.dart';

class HomeProfileTab extends StatelessWidget {
  const HomeProfileTab({super.key});

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
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(defaultRadius)),
                        child: Image.asset(
                          "assets/images/avatar.jpeg",
                          width: 100,
                        ),
                      ),
                      Text(
                        "Orphée Kablan",
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: fontHeading),
                      ),
                      Text(
                        "orpheekablan@gmail.com",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: fontSubHeading),
                      ),
                      const Chip(
                        backgroundColor: primaryLight,
                        label: Text("Modifier Profile"),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: defaultSpacing),
                      child: Text(
                        "Général",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: fontHeading),
                      ),
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    const GeneralAccountInfoTile(
                        title: "Angré 22ème",
                        subTitle: "Rue, I42 Abidjan",
                        imageUrl: "assets/icons/location-1.png"),
                    const GeneralAccountInfoTile(
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
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w700, color: fontHeading),
                      ),
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    const ProfileAccountInfoTile(
                      iconUrl: "assets/icons/user-1.png",
                      heading: "Mon Compte",
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    const ProfileAccountInfoTile(
                      iconUrl: "assets/icons/bell.png",
                      heading: "Notifications",
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    const ProfileAccountInfoTile(
                      iconUrl: "assets/icons/lock-on.png",
                      heading: "Confidentialité",
                    ),
                    const SizedBox(
                      height: defaultSpacing,
                    ),
                    const ProfileAccountInfoTile(
                      iconUrl: "assets/icons/info-circle.png",
                      heading: "À Propos",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
