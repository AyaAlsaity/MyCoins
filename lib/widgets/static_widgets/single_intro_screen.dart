import 'package:flutter/material.dart';

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
    // final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);

    return Container(
      // themeListener.isDark ? darkGreyColor : lightWihteColor,
      // color: Colors.blue.withOpacity(0.2),
      // height: size.height * 0.62,
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
                    height: size.width * 0.8,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              // SizedBox(
              //   height: size.height * 0.05,
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 61),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff191A1D)
                      // themeListener.isDark
                      //     ? lightWihteColor
                      //     : darkGreyColor
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
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff191A1D)
                      // themeListener.isDark
                      //     ? lightGreyColor.withOpacity(0.7)
                      //     : darkGreyColor.withOpacity(0.7)
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
