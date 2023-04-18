import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycoins/widgets/static_widgets/drawer_widgets/info_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helpers/consts.dart';
import '../../../main.dart';
import '../../../providers/dark_theme_provider.dart';
import 'drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    FirebaseAuth auth = FirebaseAuth.instance;
    return SizedBox(
      width: 330,
      child: Drawer(
        child: Material(
          color: themeFunctions.isDark
                          ? darkBackroundScreenColor
                          : lightBackroundScreenColor,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 70, 24, 0),
            child: Column(
              children: [
                const Infocard(
                  emailText: 'areej @ gmail.com',
                  nameText: 'Areej',
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: greyColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                    title: AppLocalizations.of(context)!.proinfo,
                    icon: Icons.person,
                    onPressed: () {}),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    title: AppLocalizations.of(context)!.favr,
                    icon: Icons.favorite_outline,
                    onPressed: () {}),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    title: AppLocalizations.of(context)!.lag,
                    icon: Icons.language,
                    onPressed: () {
                      AppLocalizations.of(context)!.localeName == 'ar'
                          ? MyApp.setLocale(context, const Locale('en'))
                          : MyApp.setLocale(context, const Locale('ar'));
                    }),
                const SizedBox(
                  height: 30,
                ),
                DrawerItem(
                    title: AppLocalizations.of(context)!.dakmo,
                    icon: themeListener.isDark ? Icons.dark_mode : Icons.sunny,
                    onPressed: () {
                      themeFunctions.switchMode();
                    }),
                const SizedBox(
                  height: 30,
                ),
                const Divider(
                  thickness: 1,
                  height: 10,
                  color: greyColor,
                ),
                const SizedBox(
                  height: 20,
                ),
                DrawerItem(
                  title: AppLocalizations.of(context)!.loout,
                  icon: Icons.logout,
                  onPressed: () async {
                    auth.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        CupertinoPageRoute(
                            builder: ((context) => const MyApp())),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
























// import 'package:flutter/material.dart';

// import 'drawer_item.dart';
// import 'info_card.dart';

// class CustomDrawer extends StatefulWidget {
//   const CustomDrawer({super.key});

//   @override
//   State<CustomDrawer> createState() => _CustomDrawerState();
// }

// class _CustomDrawerState extends State<CustomDrawer> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 288,
//       height: double.infinity,
//       color: const Color(0xFF17203A),
//       child: SafeArea(
//           child: Column(
//         children: [
//           // custom widget
//           const Infocard(
//               name: "Areej elbarassi", email: "areej.elbarassi@gmail.com"),
//           const Padding(
//             padding: EdgeInsets.only(left: 24),
//             child: Divider(color: Colors.white24, height: 1, thickness: 1),
//           ),
//           const SizedBox(
//             height: 30,
//           ),
//           DrawerItem(
//               icon: Icons.person_rounded, title: "Profile", onPressed: () {}),

//           DrawerItem(icon: Icons.star, title: "Favorite", onPressed: () {}),
//         ],
//       )),
//     );
//   }
// }