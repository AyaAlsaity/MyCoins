import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mycoins/providers/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../models/coins_search_model.dart';
import 'details_screen.dart';

class CoinSearchScreen extends StatefulWidget {
  const CoinSearchScreen({Key? key}) : super(key: key);

  @override
  State<CoinSearchScreen> createState() => _CoinSearchScreenState();
}

class _CoinSearchScreenState extends State<CoinSearchScreen> {
  String urlListMarket =
      '${baseUrl}coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1&sparkline=false';
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
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
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
                          hintText: 'Search coins',
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
                            ? const Center(
                                child: Text('No Coin Found'),
                              )
                            : ListView.separated(
                                itemCount: listCoin.length,
                                itemBuilder: (context, index) {
                                  return _buildCoin(listCoin[index]);
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
                  return const Center(child: Text('Error Occurred'));
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildCoin(CoinsearchModel coin) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const DetailsScreen()));
        },
        leading: Image.network(
          coin.image ?? '',
          width: 50,
          height: 50,
        ),
        title: Text(
          coin.name ?? '',
          style: TextStyle(
            color: themeListener.isDark ? darktitleColor : mainTextColor,
          ),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              CurrencyHelper.idr(coin.currentPrice!),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeListener.isDark ? darktitleColor : mainTextColor,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              '${coin.priceChangePercentage24h} %',
              style: const TextStyle(color: successColor),
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