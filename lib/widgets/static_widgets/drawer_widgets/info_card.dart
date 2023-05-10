import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:provider/provider.dart';

import '../../../providers/dark_theme_provider.dart';

class Infocard extends StatelessWidget {
  const Infocard({super.key, required this.nameText, required this.emailText});

  final String nameText;
  final String emailText;
  @override
  Widget build(BuildContext context) {
    final themeListener =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return ListTile(
      leading: CircleAvatar(
        backgroundColor:
            themeListener.isDark ? darkBackroundScreenColor : Colors.white,
        child: Image.asset("assets/images/woman.png"
            ),
      ),
      title: Text(
        nameText,
        style: TextStyle(
            fontSize: 14,
            color: themeListener.isDark ? darktitleColor : mainTextColor),
      ),
      subtitle: Text(emailText,
          style: TextStyle(
              fontSize: 12,
              color: themeListener.isDark ? darkMainTextColor :mainTextColor.withOpacity(0.5) )),
    );
  }
}
//    