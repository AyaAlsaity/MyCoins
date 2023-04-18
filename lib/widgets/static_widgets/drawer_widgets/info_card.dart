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
     final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return ListTile(
      leading:  CircleAvatar(
        backgroundColor: themeFunctions.isDark
                          ? darkBackroundScreenColor
                          : lightBackroundScreenColor,
        child:const Icon(
          Icons.person,
          color: mainColor,
        ),
      ),
      title: Text(
        nameText,
        style:  TextStyle(fontSize: 18, color:themeFunctions.isDark
                          ? darktitleColor
                          : mainTextColor),
      ),
      subtitle: Text(emailText,
          style:  TextStyle(fontSize: 16, color: themeFunctions.isDark
                          ? darktitleColor
                          : mainTextColor)),
    );
  }
}
//    