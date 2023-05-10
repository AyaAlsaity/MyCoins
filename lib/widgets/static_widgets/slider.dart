import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key});

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enableInfiniteScroll: true,
          height: size.height * 0.13,
          viewportFraction: 0.9,
        ),
        items: coinsConsumer.coinsList
            .map((item) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: themeListener.isDark
                                    ? darkBackroundContinarColor
                                    : lightBackroundBottomNavigationBarColor
                                        .withOpacity(0.3),
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
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            item.image.toString(),
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              item.symbol,
                                              style: TextStyle(
                                                color: themeListener.isDark
                                                    ? darktitleColor
                                                    : mainTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              item.currentPrice.toString(),
                                              style: TextStyle(
                                                color: themeListener.isDark
                                                    ? darktitleColor
                                                    : mainTextColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: size.width / 16,
                                        ),
                                        Text(
                                          '${item.athChangePercentage}%',
                                          style: TextStyle(
                                            color: green,
                                            fontSize: 12,
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
                        )),
                  ),
                ))
            .toList(),
      );
    });
  }
}
