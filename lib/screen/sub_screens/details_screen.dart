import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../models/coins_model.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/continarDarkmode.dart';
import '../../widgets/static_widgets/money_converter_widget.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.coinHome,
    required this.index,
  }) : super(key: key);
  final CoinsModel coinHome;
  final int index;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  bool isOk1 = false;
  int indexFavorite = 0;
  bool isLoading = true;
  bool isFirstTime = true;
  List<FlSpot> flSpotList = [];
  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;
  List favoriteList = [];

  void getChartData(String days) async {
    if (isFirstTime) {
      isFirstTime = false;
    } else {
      setState(() {
        isLoading = true;
      });
    }
    String api =
        '${baseUrl}/api/v3/coins/${widget.coinHome.id}/market_chart?vs_currency=idr&days=$days';
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);
      List rawList = result['prices'];
      List<List> chartData = rawList.map((e) => e as List).toList();
      List<PriceAndTime> priceAndTimeList = chartData
          .map((e) => PriceAndTime(time: e[0] as int, price: e[1] as double))
          .toList();
      flSpotList = [];
      for (var chart in priceAndTimeList) {
        flSpotList.add(FlSpot(chart.time.toDouble(), chart.price));
      }
      minX = priceAndTimeList.first.time.toDouble();
      maxX = priceAndTimeList.last.time.toDouble();
      priceAndTimeList.sort((a, b) => a.price.compareTo(b.price));
      minY = priceAndTimeList.first.price;
      maxY = priceAndTimeList.last.price;
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getChartData('1');
    getFavorites();
  }

  getFavorites() async {
    var data = await firestore
        .collection('favorites')
        .where('user_id', isEqualTo: auth.currentUser!.uid)
        .get();
    for (var i = 0; i <= data.docs.length; i++) {
      if (data.docs[i].data()['coin_id'] == widget.coinHome.id) {
        setState(() {
          isOk1 = true;
        });
      }
    }
  }

  addToFaveId(
    String coinId,
  ) {
    firestore.collection('favorites').add({
      'user_id': auth.currentUser!.uid,
      "coin_id": coinId,
      "index": widget.index,
    });

    getFavorites();
  }

  removeFaveId(
    String coinId,
  ) async {
    var deletable = await firestore
        .collection('favorites')
        .where("user_id", isEqualTo: auth.currentUser!.uid)
        .where("coin_id", isEqualTo: coinId)
        .get();
    firestore
        .collection('favorites')
        .doc(deletable.docs.first.id.toString())
        .delete()
        .then((value) {
      setState(() {
        isOk1 = false;
      });
    });
  }
// /////////////
//   addToFaveData() {
//     firestore.collection('favorites').add({
//       'ath_change_percentage': "-59.43744,",
//       'ath': "69045",
//       'max_supply': "21000000",
//       'total_supply': "19362006",
//       'circulating_supply': "-2.18024",
//       'market_cap_change_percentage_24h': "-12093227985.869446",
//       'market_cap_change_24h': "-2.04346",
//       'price_change_percentage_24h': "${widget.coin.priceChangePercentage24h}",
//       'price_change_24h': "27722",
//       'low_24h': "28669",
//       'high_24h': "28669",
//       'total_volume': "16496081189",
//       'fully_diluted_valuation': "588481479757",
//       'market_cap_rank': "1",
//       'market_cap': "588481479757",
//       'current_price': "${widget.coin.currentPrice}",
//       'image': "${widget.coin.image}",
//       'name': "${widget.coin.name}",
//       'symbol': "${widget.coin.symbol}",
//       "user_id": auth.currentUser!.uid.toString()
//     });
//   }
// ////////////

// List<DetailsMap> listDetails=[
//     DetailsMap(
//       name: 'Market cap',
//       number:widget.conHome.marketCap,
//     ),
//     DetailsMap(
//       name: 'Market cap rank',
//       number:widget.conHome.marketCapRank,
//     ),
//     DetailsMap(
//       name: 'Fully diluted valuation',
//       number:widget.conHome.fullyDilutedValuation,
//     ),
//     DetailsMap(
//       name: 'Total volume',
//       number:widget.conHome.totalVolume,
//     ),
//     DetailsMap(
//       name: 'Low 24h',
//       number:widget.conHome.low24H,
//     ),
//     DetailsMap(
//       name: 'Price change 24h',
//       number:widget.conHome.priceChange24H,
//     ),
//     DetailsMap(
//       name: 'Price change 24h',
//       number:widget.conHome.priceChangePercentage24H,
//     ),
//     DetailsMap(
//       name: 'Market cap change 24h',
//       number:widget.conHome.marketCapChange24H,
//     ),
//     DetailsMap(
//       name: 'Circulating supply',
//       number:widget.conHome.circulatingSupply,
//     ),
//     DetailsMap(
//       name: 'Total supply',
//       number:widget.conHome.totalSupply,
//     ),
//     DetailsMap(
//       name: 'Max supply',
//       number:widget.conHome.maxSupply,
//     ),
//     DetailsMap(
//       name: 'Ath',
//       number:widget.conHome.ath,
//     ),
//     DetailsMap(
//       name: 'Ath change percentage',
//       number:widget.conHome.athChangePercentage,
//     ),
//   ];

//   // List<DetailsMap> listDetails = [
//   //   DetailsMap(
//   //     name: 'Market cap',
//   //     number: 586578312211,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Market cap rank',
//   //     number: 1,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Fully diluted valuation',
//   //     number: 636680751892,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Total volume',
//   //     number: 10921213123,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Low 24h',
//   //     number: 30266,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Price change 24h',
//   //     number: -201.61235264851712,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Price change 24h',
//   //     number: -0.66046,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Market cap change 24h',
//   //     number: -4616510575.362671,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Market cap change 24h',
//   //     number: -0.78088,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Circulating supply',
//   //     number: 19347443.0,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Total supply',
//   //     number: 21000000.0,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Max supply',
//   //     number: 21000000.0,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Ath',
//   //     number: 69045,
//   //   ),
//   //   DetailsMap(
//   //     name: 'Ath change percentage',
//   //     number: -56.07955,
//   //   ),
//   // ];

  @override
  Widget build(BuildContext context) {
    CollectionReference favorites = firestore.collection('favorites');
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  widget.coinHome.image.toString(),
                  width: 25,
                  height: 25,
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                widget.coinHome.symbol.toString().toUpperCase(),
                style: TextStyle(
                  fontSize: 14,
                  color: themeFunctions.isDark ? darktitleColor : mainTextColor,
                ),
              ),
              Text(
                widget.coinHome.name.toString(),
                style: TextStyle(
                    color:
                        themeFunctions.isDark ? darktitleColor : mainTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                // if (isOk1 == true) {
                isOk1
                    ? removeFaveId(widget.coinHome.id.toString())
                    : addToFaveId(widget.coinHome.id.toString());

                // firestore.collection('favorites').where('user_id' , isEqualTo: auth.currentUser!.uid.toString() ).get();
                // } else {
                //   // firestore.collection('favorites').where('user_id' , isEqualTo: auth.currentUser!.uid.toString());
                // }
              },
              icon: Icon(
                isOk1 ? Icons.star : Icons.star_border_outlined,
                color: mainColor,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => const moneyConverter()));
          },
          child: const Icon(Icons.local_convenience_store_rounded),
        ),
        body: RefreshIndicator(
          color: mainColor,
          backgroundColor: themeFunctions.isDark
              ? darkBackroundContinarColor
              : secondeyTextColor,
          onRefresh: () async {
            //
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          '\$ ${widget.coinHome.currentPrice.toString()}',
                          style: TextStyle(
                            fontSize: 20,
                            color: themeFunctions.isDark
                                ? darktitleColor
                                : mainTextColor,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          '${widget.coinHome.priceChangePercentage24H} %',
                          style: const TextStyle(
                            color: warningColor,
                            fontSize: 12,
                          ),
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
                          image: widget.coinHome.image.toString(),
                          price: '1.00',
                          symbol: 'btc',
                        ),
                        ContinarDarkMode(
                          image:
                              'https://www.pngall.com/wp-content/uploads/10/USD-Coin-Logo-PNG-Photo.png',
                          price: widget.coinHome.currentPrice.toString(),
                          symbol: 'usd',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: sizedBoxNotSameComponents + 10,
                    ),
                    Container(
                      width: size.width,
                      height: size.width / 1.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(paddingAll),
                        color: themeFunctions.isDark
                            ? darkBackroundContinarColor
                            : secondeyTextColor,
                      ),
                      child: isLoading == false
                          ? Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: LineChart(
                                      LineChartData(
                                        minX: minX,
                                        minY: minY,
                                        maxX: maxX,
                                        maxY: maxY,
                                        titlesData: FlTitlesData(show: false),
                                        borderData: FlBorderData(show: false),
                                        gridData: FlGridData(
                                          getDrawingHorizontalLine: (value) =>
                                              FlLine(strokeWidth: 0),
                                          getDrawingVerticalLine: (value) =>
                                              FlLine(strokeWidth: 0),
                                        ),
                                        lineBarsData: [
                                          LineChartBarData(
                                            color: mainColor,
                                            spots: flSpotList,
                                            dotData: FlDotData(show: false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: sizedBoxNotSameComponents,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () => getChartData('1'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: mainColor.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 8),
                                          child: Text(
                                            '1 D',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => getChartData('15'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: mainColor.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 8),
                                          child: Text(
                                            '15 D',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () => getChartData('30'),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: mainColor.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 25, vertical: 8),
                                          child: Text(
                                            '30 D',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: sizedBoxNotSameComponents,
                                ),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: sizedBoxNotSameComponents + 10,
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 1.17,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(paddingAll),
                        color: themeFunctions.isDark
                            ? darkBackroundContinarColor
                            : secondeyTextColor,
                      ),
                      child: Column(
                        children: [
                          Desdetails(
                            name: 'Market cap',
                            number: widget.coinHome.marketCap,
                          ),
                          Desdetails(
                            name: 'Market cap rank',
                            number: widget.coinHome.marketCapRank,
                          ),
                          Desdetails(
                            name: 'Fully diluted valuation',
                            number: widget.coinHome.fullyDilutedValuation,
                          ),
                          Desdetails(
                            name: 'Total volume',
                            number: widget.coinHome.totalVolume,
                          ),
                          Desdetails(
                            name: 'Low 24h',
                            number: widget.coinHome.low24H,
                          ),
                          Desdetails(
                            name: 'Price change 24h',
                            number: widget.coinHome.priceChange24H,
                          ),
                          Desdetails(
                            name: 'Price change Percentage 24h',
                            number: widget.coinHome.priceChangePercentage24H,
                          ),
                          Desdetails(
                            name: 'Market cap change 24h',
                            number: widget.coinHome.marketCapChange24H,
                          ),
                          Desdetails(
                            name: 'Circulating supply',
                            number: widget.coinHome.circulatingSupply,
                          ),
                          Desdetails(
                            name: 'Total supply',
                            number: widget.coinHome.totalSupply,
                          ),
                          Desdetails(
                            name: 'Max supply',
                            number: widget.coinHome.maxSupply,
                          ),
                          Desdetails(
                            name: 'Ath',
                            number: widget.coinHome.ath,
                          ),
                          Desdetails(
                            name: 'Ath change percentage',
                            number: widget.coinHome.athChangePercentage,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class PriceAndTime {
  late int time;
  late double price;

  PriceAndTime({required this.time, required this.price});
}

class Desdetails extends StatelessWidget {
  Desdetails({
    super.key,
    required this.name,
    required this.number,
  });
  String name;
  String number;

  @override
  Widget build(BuildContext context) {
    final themeFunctions =
        Provider.of<DarkThemeProvider>(context, listen: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: paddingAll),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 12,
                  color: themeFunctions.isDark
                      ? darkMainTextColor
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: 10,
                  color: themeFunctions.isDark ? darktitleColor : mainTextColor,
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
    );
  }
}
