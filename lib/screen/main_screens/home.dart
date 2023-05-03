import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:mycoins/widgets/clickable_widgets/carrenci_colum_data.dart';
import 'package:provider/provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../../widgets/static_widgets/slider.dart';
import '../sub_screens/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
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
      body: RefreshIndicator(
        color: mainColor,
        backgroundColor: themeFunctions.isDark
            ? darkBackroundContinarColor
            : secondeyTextColor,
        onRefresh: () async {
          //
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                  child: const SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: CarrenciColumData()))

              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
