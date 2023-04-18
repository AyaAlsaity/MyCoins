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
     final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
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
              style:  TextStyle(fontSize: 16, color: themeFunctions.isDark
                          ? darktitleColor
                          : mainTextColor),
            )
          ],
        ),
      ),
    );

    //  Column(
    //   children: [
    //     // const Padding(
    //     //   padding: EdgeInsets.only(left: 24),
    //     //   child: Divider(
    //     //     color: Colors.white24,
    //     //     height: 1,
    //     //   ),
    //     // ),
    //     ListTile(
    //       onTap: onPressed,
    //       leading: SizedBox(
    //           height: 100,
    //           width: 80,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Icon(
    //                 icon,
    //                 size: 20,
    //                 color: Colors.white,
    //               ),
    //               const SizedBox(
    //                 width: sizedBoxSameComponents,
    //               ),
    //               Text(
    //                 title,
    //                 style: const TextStyle(fontSize: 16, color: Colors.white),
    //               )
    //             ],
    //           )),
    //     ),
    //   ],
    // );
  }
}
