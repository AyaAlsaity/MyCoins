import 'package:flutter/material.dart';
import 'package:mycoins/screen/main_screens/home.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../sub_screens/favorite_screen.dart';
import '../sub_screens/profile_screen.dart';

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
            ? const ProfileScreen()
            : currentIndex == 1
                ? const FavoriteScreen()
                : const HomeScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:  themeFunctions.isDark
          ? darkBackroundBottomNavigationBarColor
          : lightBackroundBottomNavigationBarColor,
        elevation: 0.5,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: successColor,
        unselectedItemColor: warningColor,
        items: [
          BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/icons/profileIcon.png',
                width: size.width / 13,
                height: size.width / 13,
                fit: BoxFit.contain,
                color:
                    currentIndex == 0 ? mainColor : mainColor.withOpacity(0.6),
              )),
              BottomNavigationBarItem(
              label: '',
              icon:Icon(Icons.star,
              size: size.width/11,
              color:
                    currentIndex == 1 ? mainColor : mainColor.withOpacity(0.6), 
              ),
              ),
               BottomNavigationBarItem(
              label: '',
              icon: Image.asset(
                'assets/icons/homeIcon.png',
                width: size.width / 13,
                height: size.width / 13,
                color:
                    currentIndex == 2? mainColor : mainColor.withOpacity(0.6),
                fit: BoxFit.contain,
              )),
             
         
        ],
      ),
    );
  }
}
