import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (_) => const IntroScreen()));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
       appBar: AppBar(
      elevation: 0,
        // systemOverlayStyle: const SystemUiOverlayStyle(
        //   statusBarColor: darkBackroundScreenColor,
        // ),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/logo2.png',
          height: size.height * 0.9,
          width: size.width * 0.9,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
