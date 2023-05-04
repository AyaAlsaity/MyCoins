import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:mycoins/widgets/clickable_widgets/carrenci_colum_data.dart';
import 'package:provider/provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
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
      appBar:AppBarWidget(context),
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
