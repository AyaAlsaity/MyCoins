import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class SingleIntroScreen extends StatelessWidget {
  const SingleIntroScreen(
      {Key? key,
      required this.title,
      required this.description,
      required this.image})
      : super(key: key);
  final String title;
  final String description;
  final String image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Container(
      child: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.67,
                ),
                child: Center(
                  child: Image.asset(
                    image,
                    width: size.width * 0.66,
                    height: size.width * 0.62,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 61),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroCard extends StatelessWidget {
  const IntroCard(
      {super.key,
      required this.image,
      required this.title,
      required this.description});
  final String image;
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Column(
      children: [
        Image.asset(
          image,
          width: size.width,
          height: size.height * 0.4,
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: themeListener.isDark ? darktitleColor : mainTextColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: themeListener.isDark ? darktitleColor : mainTextColor,
            ),
          ),
        ),
      ],
    );
  }
}
