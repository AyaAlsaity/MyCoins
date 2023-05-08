import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class ContinarDarkMode extends StatelessWidget {
  String image;
  String symbol;
  String price;
  ContinarDarkMode({
    Key? key,
    required this.image,
    required this.symbol,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2.3,
      height: size.width / 6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(paddingAll),
        color: 
        themeFunctions.isDark
                          ? darkBackroundContinarColor
                          : secondeyTextColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(paddingAll),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  symbol.toUpperCase(),
                  style:
                       TextStyle(fontSize: 12, color: themeFunctions.isDark
                          ? darkMainTextColor
                          : Colors.grey.shade700, ),
                ),
                const SizedBox(
                  width: sizedBoxSameComponents,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        image,
                        width: 15,
                        height: 15,
                      ),
                    ),
                    const SizedBox(
                      height: sizedBoxSameComponents,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              width: sizedBoxSameComponents+5,
            ),

            Container(
              width: size.width/300,
              height: size.width / 5,
              decoration:const BoxDecoration(
                // borderRadius: BorderRadius.circular(paddingAll),
                color: darksecondeyTextColor,
              ),
            ),

            const SizedBox(
              width: sizedBoxSameComponents+3,
            ),
            Text(
              price,
              style:  TextStyle(fontSize: 12, color: themeFunctions.isDark
                          ? darkMainTextColor
                          : themeFunctions.isDark
                          ? darkMainTextColor
                          : mainTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
