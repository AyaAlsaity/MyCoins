import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:mycoins/screen/sub_screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/dark_theme_provider.dart';
import '../../widgets/clickable_widgets/notification_tiles.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../main_screens/conversion.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),
        title: const Text(
          "My Coins",
          style: TextStyle(
              color: mainColor, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          SizedBox(
              height: 30,
              width: 30,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const CoinSearchScreen()));
                  },
                  child: const Icon(Icons.search)))
        ],
      ),
      drawer: const CustomDrawer(),
      body: ListView.separated(
          physics: const ClampingScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: 12,
          itemBuilder: (context, index) {
            return NotificationTiles(
              title: 'My Coins',
              subtitle: 'Thanks for download My Coins app.',
              enable: true,
              ontap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationDetails())),
              key: null,
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          }),
    );
  }
}

class NotificationDetails extends StatefulWidget {
  const NotificationDetails({super.key});

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),
      ),
      body: FittedBox(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(16.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            //    color: themeListener.isDark ? greyTextColor : greyColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: [
              Text(
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: themeListener.isDark
                        ? secondeyTextColor
                        : Colors.black87,
                  )),
              const SizedBox(height: 16.0),
              Image.asset("assets/images/logo2.png"),
              const SizedBox(height: 16.0),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                  style: TextStyle(
                    color: themeListener.isDark
                        ? secondeyTextColor
                        : Colors.black87,
                  )),
              const SizedBox(height: 16.0),
              Align(
                alignment: Alignment.centerRight,
                child: Text('1/May/2021 10:01 PM',
                    style: TextStyle(
                      color: themeListener.isDark
                          ? secondeyTextColor
                          : Colors.black87,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
