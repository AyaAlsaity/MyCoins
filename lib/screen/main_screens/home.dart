import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:mycoins/screen/sub_screens/notifications_screen.dart';
import 'package:mycoins/widgets/clickable_widgets/carrenci_colum_data.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../../widgets/static_widgets/slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
        child: Column(
          children:   [
             const SizedBox(
              height: 20,
            ),
             const SliderWidget(),
              
               const SizedBox(
              height: 20,
            ),
              SizedBox(
                width: double.infinity,
                height: size.height,
                child:  const SingleChildScrollView(
                  scrollDirection : Axis.horizontal,
                  child: CarrenciColumData())
                  )

            //   ),
          ],
        ),
      ),
    );
  }
}
