import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';

class HomeSliderCard extends StatefulWidget {
  const HomeSliderCard({super.key});

  @override
  State<HomeSliderCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeSliderCard> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Column(
      children: [
        // ClipRRect(
        //   borderRadius: const BorderRadius.only(
        //     topLeft: Radius.circular(24),
        //     topRight: Radius.circular(24),
        //   ),
        //   child: SizedBox(
        //     width: double.infinity,
        //     height: 200,
        //     child: Image.asset(
        //       'assets/images/stockmarket.jpg',
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color: themeListener.isDark
                ? darkBackroundContinarColor
                : secondeyTextColor,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 70,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [
                        0.3,
                        2
                      ],
                      colors: [
                        mainColor,
                        Color(0xFFF7DC6F),
                      ]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                  ),
                  // .all(
                  //   Radius.circular(24),
                  // )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        Text(
                          'Text',
                          style: TextStyle(
                            color: themeListener.isDark
                                ? darktitleColor
                                : mainTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$26,220,000',
                          style: TextStyle(
                            color: themeListener.isDark
                                ? darktitleColor
                                : mainTextColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 140,
                    ),
                    Text(
                      '+2,304%',
                      style: TextStyle(
                        color: green,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
