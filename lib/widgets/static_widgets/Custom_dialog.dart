import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.btnText,
      required this.onpress,
      required this.image});
  final String title;
  final String subtitle;
  final String btnText;
  final VoidCallback onpress;
  final Widget image;

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Dialog(
      backgroundColor:
          themeListener.isDark ? darkBackroundContinarColor : secondeyTextColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: 260,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(children: [
                  const SizedBox(
                    height: sizedBoxSameComponents,
                  ),
                  Text(
                    subtitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: themeListener.isDark
                            ? darktitleColor
                            : mainTextColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                  const SizedBox(
                    height: sizedBoxNotSameComponents,
                  ),
                ]),
              ),
            ),
            Positioned(
              top: -60,
              child: CircleAvatar(
                backgroundColor: mainColor,
                radius: 60,
                child: image,
              ),
            )
          ]),
    );
  }
}
