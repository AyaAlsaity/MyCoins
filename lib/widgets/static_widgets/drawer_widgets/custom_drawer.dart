import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycoins/screen/auth_screens/sign_in_screen.dart';
import 'package:mycoins/widgets/static_widgets/drawer_widgets/info_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../helpers/consts.dart';
import '../../../main.dart';
import '../../../providers/dark_theme_provider.dart';
import '../../../providers/get_from_fire_storge_provider.dart';
import '../../../screen/sub_screens/connect_screen.dart';
import '../../../screen/sub_screens/favorite_screen.dart';
import '../../../screen/sub_screens/settings_screen.dart';
import 'drawer_item.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  FirebaseAuth auth = FirebaseAuth.instance;
  QuerySnapshot? listUsers;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? listuser;

  @override
  void initState() {
    Provider.of<FireStorgeProvoder>(context, listen: false).getUser();
    super.initState();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: false);

    return Consumer<FireStorgeProvoder>(
        builder: (context, userFireStorgeConsumer, _) {
      return SizedBox(
        width: 330,
        child: Drawer(
          child: Material(
            color: themeListener.isDark
                ? darkBackroundScreenColor
                : secondeyTextColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 70, 24, 0),
              child: Column(
                children: [
                  Infocard(
                    emailText: userFireStorgeConsumer.email,
                    nameText: userFireStorgeConsumer.name,
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
                      title: AppLocalizations.of(context)!.favr,
                      icon: Icons.star,
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const FavoriteScreen()));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItem(
                      title:
                          " ${AppLocalizations.of(context)!.lag}   (${AppLocalizations.of(context)!.localeName == 'en' ? (AppLocalizations.of(context)!.lanen) : (AppLocalizations.of(context)!.lanar)})",
                      icon: Icons.language,
                      onPressed: () {
                        AppLocalizations.of(context)!.localeName == 'en'
                            ? MyApp.setLocale(context, const Locale('ar'))
                            : MyApp.setLocale(context, const Locale('en'));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItem(
                      title: themeListener.isDark
                          ? AppLocalizations.of(context)!.lakmo
                          : AppLocalizations.of(context)!.dakmo,
                      icon:
                          themeListener.isDark ? Icons.sunny : Icons.dark_mode,
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
                      title: AppLocalizations.of(context)!.settings,
                      icon: Icons.settings,
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const SettingScreen()));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItem(
                      title: AppLocalizations.of(context)!.helpsupport,
                      icon: Icons.help,
                      onPressed: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const ConnectScreen()));
                      }),
                  const SizedBox(
                    height: 10,
                  ),
                  DrawerItem(
                    title: AppLocalizations.of(context)!.loout,
                    icon: Icons.logout,
                    onPressed: () async {
                      auth.signOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          CupertinoPageRoute(
                              builder: ((context) => const LoginScreen())),
                          (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
