import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';

import '../../main.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../sub_screens/notifications_screen.dart';
import '../sub_screens/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          // iconTheme: const IconThemeData(color: mainColor),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('DetailsScreen'),
          ),
          IconButton(
              onPressed: () async {
              
                Navigator.push(
                    context,
                    CupertinoPageRoute(builder: ((context) => const DetailsScreen())),
                );
              },
              icon: const Icon(
                Icons.start,
              )),
        ],
      ),
    );
  }
}
