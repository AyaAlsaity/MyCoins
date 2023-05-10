import 'package:flutter/material.dart';
import 'package:mycoins/helpers/consts.dart';
import 'package:provider/provider.dart';

import '../../../providers/dark_theme_provider.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onPressed});
  final IconData icon;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return InkWell(
      focusColor: mainColor.withOpacity(0.1),
      splashColor: mainColor.withOpacity(0.4),
      onTap: onPressed,
      child: SizedBox(
        height: 40,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20,
              color: mainColor,
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: themeListener.isDark ? darktitleColor : mainTextColor),
            )
          ],
        ),
      ),
    );
  }
}
