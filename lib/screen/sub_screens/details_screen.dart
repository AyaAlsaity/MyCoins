import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../models/details_map.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/continarDarkmode.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isOk1 = false;

  List<DetailsMap> listDetails = [
    DetailsMap(
      name: 'Market cap',
      number: 586578312211,
    ),
    DetailsMap(
      name: 'Market cap rank',
      number: 1,
    ),
    DetailsMap(
      name: 'Fully diluted valuation',
      number: 636680751892,
    ),
    DetailsMap(
      name: 'Total volume',
      number: 10921213123,
    ),
    DetailsMap(
      name: 'Low 24h',
      number: 30266,
    ),
    DetailsMap(
      name: 'Price change 24h',
      number: -201.61235264851712,
    ),
    DetailsMap(
      name: 'Price change 24h',
      number: -0.66046,
    ),
    DetailsMap(
      name: 'Market cap change 24h',
      number: -4616510575.362671,
    ),
    DetailsMap(
      name: 'Market cap change 24h',
      number: -0.78088,
    ),
    DetailsMap(
      name: 'Circulating supply',
      number: 19347443.0,
    ),
    DetailsMap(
      name: 'Total supply',
      number: 21000000.0,
    ),
    DetailsMap(
      name: 'Max supply',
      number: 21000000.0,
    ),
    DetailsMap(
      name: 'Ath',
      number: 69045,
    ),
    DetailsMap(
      name: 'Ath change percentage',
      number: -56.07955,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: darkBackroundScreenColor,
        ),

        // leading:

        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              'Bitcoin',
              style: TextStyle(
                  color: themeFunctions.isDark ? darktitleColor : mainTextColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              '(btc)'.toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: themeFunctions.isDark ? darktitleColor : mainTextColor,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isOk1 = !isOk1;
              });
            },
            icon: Icon(
              isOk1 ? Icons.favorite : Icons.favorite_border_outlined,
              color: mainColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(paddingAll),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment : MainAxisAlignment.center,
                children: [
                  Text(
                    '586578312211', //$ ?
                    style: TextStyle(
                      fontSize: 24,
                      color: themeFunctions.isDark
                          ? darktitleColor
                          : mainTextColor,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const Text(
                    '0.66046 - %',
                    style: TextStyle(color: warningColor),
                  ),
                ],
              ),
              const SizedBox(
                height: sizedBoxNotSameComponents,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ContinarDarkMode(
                    //Static
                    image:
                        'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579',
                    price: '1.00',
                    symbol: 'btc',
                  ),
                  ContinarDarkMode(
                    image:
                        'https://www.pngall.com/wp-content/uploads/10/USD-Coin-Logo-PNG-Photo.png',
                    price: 30325.toString(),
                    symbol: 'usd',
                  ),
                ],
              ),
              const SizedBox(
                height: sizedBoxNotSameComponents + 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingAll),
                child: Container(
                  width: size.width,
                  height: size.height * 1.13,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(paddingAll),
                    color: themeFunctions.isDark
                        ? darkBackroundContinarColor
                        : secondeyTextColor,
                  ),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listDetails.length,
                    itemBuilder: ((context, index) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: paddingAll),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    listDetails[index].name,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: themeFunctions.isDark
                                          ? darkMainTextColor
                                          : Colors.grey.shade700,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    listDetails[index].number.toString(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: themeFunctions.isDark
                                          ? darktitleColor
                                          : mainTextColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Divider(
                                height: 1,
                                color: themeFunctions.isDark
                                    ? darksecondeyTextColor
                                    : Colors.grey.shade400,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                            ],
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
