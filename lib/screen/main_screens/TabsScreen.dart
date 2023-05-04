import 'package:flutter/material.dart';
import 'package:mycoins/screen/main_screens/home.dart';
import 'package:mycoins/screen/main_screens/notifications_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import 'conversion.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int currentIndex = 2;
  @override
  Widget build(BuildContext context) {
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedSwitcher(
        // animationDuration
        duration: kThemeAnimationDuration,
        child: currentIndex == 0
            ? const NotificationsScreen()
            // : currentIndex == 1
            //     ? const CoinSearchScreen()
            : currentIndex == 1
                ? const ConversionScreen()
                : const HomeScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeFunctions.isDark
            ? darkBackroundBottomNavigationBarColor
            : lightBackroundBottomNavigationBarColor,
        elevation: 0.5,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: mainColor,
        items: [
          BottomNavigationBarItem(
              label: currentIndex == 0 ? AppLocalizations.of(context)!.notification : "",
              icon: Image.asset(
                'assets/icons/notificationIcon.png',
                width: currentIndex == 0 ? size.width / 12 : size.width / 15,
                height: currentIndex == 0 ? size.width / 12 : size.width / 15,
                fit: BoxFit.contain,
                color:
                    currentIndex == 0 ? mainColor : mainColor.withOpacity(0.6),
              )),
          BottomNavigationBarItem(
              label: currentIndex == 1 ? AppLocalizations.of(context)!.conversion : "",
              icon: Column(
                children: [
                  Image.asset(
                    'assets/icons/currency_exchange.png',
                    width:
                        currentIndex == 1 ? size.width / 12 : size.width / 15,
                    height:
                        currentIndex == 1 ? size.width / 12 : size.width / 15,
                    fit: BoxFit.contain,
                    color: currentIndex == 1
                        ? mainColor
                        : mainColor.withOpacity(0.6),
                  ),
                ],
              )),
          BottomNavigationBarItem(
              label: currentIndex == 2 ? AppLocalizations.of(context)!.market : "",
              icon: Image.asset(
                'assets/icons/monitoring.png',
                width: currentIndex == 2 ? size.width / 12 : size.width / 15,
                height: currentIndex == 2 ? size.width / 12 : size.width / 15,
                color:
                    currentIndex == 2 ? mainColor : mainColor.withOpacity(0.6),
                fit: BoxFit.contain,
              )),
        ],
      ),
    );
  }
}
