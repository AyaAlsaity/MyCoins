import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:mycoins/providers/dark_theme_provider.dart';
import '../../helpers/consts.dart';
import '../../models/coins_model.dart';
import '../../models/coins_search_model.dart';
import '../../providers/coins_provider.dart';
import '../../widgets/static_widgets/error_widget.dart';
import 'details_screen.dart';

class CoinSearchScreen extends StatefulWidget {
  const CoinSearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CoinSearchScreen> createState() => _CoinSearchScreenState();
}

class _CoinSearchScreenState extends State<CoinSearchScreen> {
  late CoinsModel coinModelHome;
  String urlListMarket =
      '$baseUrl/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1&sparkline=false';
  List<CoinsearchModel> listCoin = [];
  late Future<List<CoinsearchModel>> listCoinFuture;
  bool isFirstTimeDataAccess = true;

  Future<List<CoinsearchModel>> getListCoins() async {
    final response = await http.get(Uri.parse(urlListMarket));
    if (response.statusCode == 200) {
      List result = json.decode(response.body);
      final data =
          result.map((json) => CoinsearchModel.fromJson(json)).toList();
      return data;
    } else {
      return <CoinsearchModel>[];
    }
  }

  @override
  void initState() {
    super.initState();
    listCoinFuture = getListCoins();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return Scaffold(
        appBar: AppBar(),
        body: RefreshIndicator(
          color: mainColor,
          backgroundColor: themeListener.isDark
              ? darkBackroundContinarColor
              : secondeyTextColor,
          onRefresh: () async {
            getListCoins();
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: FutureBuilder(
                future: listCoinFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (isFirstTimeDataAccess) {
                      listCoin = snapshot.data!;
                      isFirstTimeDataAccess = false;
                    }

                    return Column(
                      children: [
                        TextField(
                          style: TextStyle(
                            color: themeListener.isDark
                                ? darktitleColor
                                : mainTextColor,
                          ),
                          onChanged: (query) {
                            List<CoinsearchModel> searchResult =
                                snapshot.data!.where((coin) {
                              String name = coin.name!.toLowerCase();
                              bool isFound = name.contains(query);
                              return isFound;
                            }).toList();
                            setState(() {
                              listCoin = searchResult;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.search,
                              color: mainColor,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: themeListener.isDark
                                      ? darkBackroundContinarColor
                                      : mainTextColor,
                                )),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: mainColor)),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: mainColor),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: TextStyle(
                              color: themeListener.isDark
                                  ? darktitleColor
                                  : mainTextColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: listCoin.isEmpty
                              ? SingleChildScrollView(
                                  child: Text(
                                    AppLocalizations.of(context)!.error1,
                                    style: TextStyle(
                                      color: themeListener.isDark
                                          ? darktitleColor
                                          : mainTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : ListView.separated(
                                  itemCount: listCoin.length,
                                  itemBuilder: (context, index) {
                                    //////=>
                                    coinModelHome =
                                        coinsConsumer.coinsList[index];
                                    //  getModel(coinModelHome);
                                    return _buildCoin(
                                        listCoin[index], coinModelHome, index);
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(
                                    color: greyColor,
                                  ),
                                ),
                        ),
                      ],
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return ErrorWwidget(
                      error: AppLocalizations.of(context)!.error2,
                      image: 'assets/images/error1.png',
                    );
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }

  Padding _buildCoin(CoinsearchModel coin, CoinsModel listDetails, int index) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                        coinHome: listDetails,
                        index: index,
                      )));
        },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            coin.image ?? '',
            width: 30,
            height: 30,
          ),
        ),
        title: Text(
          coin.name ?? '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: themeListener.isDark ? darktitleColor : mainTextColor,
            fontSize: 14,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CurrencyHelper.idr(coin.currentPrice!),
              style: TextStyle(
                color: themeListener.isDark ? darktitleColor : mainTextColor,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${coin.priceChangePercentage24h} %',
              style: const TextStyle(
                color: successColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrencyHelper {
  static String idr(double number) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp. ',
      decimalDigits: 0,
    );
    return currencyFormatter.format(number);
  }
}
