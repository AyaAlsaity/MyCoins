import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';

class HomeSliderCard extends StatefulWidget {
  const HomeSliderCard(
      {super.key,
      required this.name,
      required this.price,
      required this.marketCapChange24H});
  final String name;
  final String price;
  final String marketCapChange24H;

  @override
  State<HomeSliderCard> createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeSliderCard> {
  @override
  void initState() {
    Provider.of<CoinsProvider>(context, listen: false).getCoins();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return Column(
        children: [
          Container(
            width: double.infinity,
            // height: 70,
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
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Container(
                      //   width: 20,
                      //   height: 20,
                      //   decoration: BoxDecoration(
                      //       color: Colors.grey,
                      //       borderRadius: BorderRadius.circular(20)),
                      //   child: Image.network(
                      //       'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579'),
                      // ),
                      Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(height: 5),
                          Text(
                            'Text',
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
                            '\$26,220,000',
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
                      const SizedBox(
                        width: 80,
                      ),
                      Text(
                        '+2,304%',
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
      );
    });
  }
}
