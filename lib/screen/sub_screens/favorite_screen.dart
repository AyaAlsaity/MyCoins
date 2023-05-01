import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import 'notifications_screen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool isOk1 = false;
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
     Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: darkBackroundScreenColor,
          ),
          title: const Center(
              child: Text(
            "My Coins",
            style: TextStyle(
                color: mainColor, fontSize: 24, fontWeight: FontWeight.w600),
          )),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const NotificationsScreen()));
              },
              icon: const Icon(
                Icons.notifications,
              ),
            )
          ]),
      drawer: const CustomDrawer(),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // const SizedBox(
            //   height: 50,
            // ),
            Container(
              width: double.infinity,
              height: size.width/4,
              decoration: BoxDecoration(
                  color: themeListener.isDark
                      ? darkBackroundContinarColor
                      : secondeyTextColor,
                  borderRadius: BorderRadius.circular(24)
                ),
                child:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                  'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                  width: 40,
                  height: 40,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              children: [
                const SizedBox(
              height: 15,
            ),
            
                  Row(
                    children: [
                       Text(
              'Bitcoin',
              style: TextStyle(
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
                      Text(
                        '(btc)'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16,
                          color: themeListener.isDark ? darktitleColor : mainTextColor,
                        ),
                      ),
                    ],
                  ),
                   const SizedBox(
              height: 5,
            ),
                  Text(
                    '\$30325',
                    style: TextStyle(
                      fontSize: 14,
                      color: themeListener.isDark ? darktitleColor : mainTextColor,
                    ),
                  ),
              ],
            ),
             IconButton(
            onPressed: () {
              setState(() {
                isOk1 = !isOk1;
              });
            },
            icon: Icon(
              isOk1 ?Icons.star_border_outlined: Icons.star ,
              color: mainColor,
            ),
          ),
          ],
        ),
                ),
        
            ),
          ],
        ),
      ),
    );
  }
}