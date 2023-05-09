import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../models/coins_model.dart';
import '../../models/details_map_model.dart';
import '../../providers/dark_theme_provider.dart';
import '../../providers/get_from_fire_storge_provider.dart';
import '../../widgets/static_widgets/continarDarkmode.dart';

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

  bool isOk = false;
  int indexFavorite = 0;
  bool isLoading = true;
  bool isFirstTime = true;
  List<FlSpot> flSpotList = [];
  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;
  // List favoriteList = [];

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
    Provider.of<FireStorgeProvoder>(context, listen: false)
        .getFavorites(widget.coinHome.id.toString());

    getChartData('1');
    setState(() {
      isOk = Provider.of<FireStorgeProvoder>(context, listen: false).isOk;
    });
    super.initState();
  }

  // getFavorites() async {
  //   var data = await firestore
  //       .collection('favorites')
  //       .where('user_id', isEqualTo: auth.currentUser!.uid)
  //       .get();
  //   for (var i = 0; i <= data.docs.length; i++) {
  //     if (data.docs[i].data()['coin_id'] == widget.coinHome.id) {
  // setState(() {
  //   isOk1 = true;
  // });
  //     }
  //   }
  // }

  // addToFaveId(
  //   String coinId,
  // ) {
  //   firestore.collection('favorites').add({
  //     'user_id': auth.currentUser!.uid,
  //     "coin_id": coinId,
  //     "index": widget.index,
  //   });

  //   getFavorites();
  // }

  // removeFaveId(
  //   String coinId,
  // ) async {
  //   var deletable = await firestore
  //       .collection('favorites')
  //       .where("user_id", isEqualTo: auth.currentUser!.uid)
  //       .where("coin_id", isEqualTo: coinId)
  //       .get();
  //   firestore
  //       .collection('favorites')
  //       .doc(deletable.docs.first.id.toString())
  //       .delete()
  //       .then((value) {
  //     setState(() {
  //       isOk1 = false;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    List<DetailsMapModel> listDetails = [
      DetailsMapModel(
        name: 'Market cap',
        number: widget.coinHome.marketCap,
      ),
      DetailsMapModel(
        name: 'Market cap rank',
        number: widget.coinHome.marketCapRank,
      ),
      DetailsMapModel(
        name: 'Fully diluted valuation',
        number: widget.coinHome.fullyDilutedValuation,
      ),
      DetailsMapModel(
        name: 'Total volume',
        number: widget.coinHome.totalVolume,
      ),
      DetailsMapModel(
        name: 'Low 24h',
        number: widget.coinHome.low24H,
      ),
      DetailsMapModel(
        name: 'Price change 24h',
        number: widget.coinHome.priceChange24H,
      ),
      DetailsMapModel(
        name: 'Price change 24h',
        number: widget.coinHome.priceChangePercentage24H,
      ),
      DetailsMapModel(
        name: 'Market cap change 24h',
        number: widget.coinHome.marketCapChange24H,
      ),
      DetailsMapModel(
        name: 'Circulating supply',
        number: widget.coinHome.circulatingSupply,
      ),
      DetailsMapModel(
        name: 'Total supply',
        number: widget.coinHome.totalSupply,
      ),
      DetailsMapModel(
        name: 'Max supply',
        number: widget.coinHome.maxSupply,
      ),
      DetailsMapModel(
        name: 'Ath',
        number: widget.coinHome.ath,
      ),
      DetailsMapModel(
        name: 'Ath change percentage',
        number: widget.coinHome.athChangePercentage,
      ),
    ];

    CollectionReference favorites = firestore.collection('favorites');
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    Size size = MediaQuery.of(context).size;
    return Consumer<FireStorgeProvoder>(
        builder: (context, coinsFireStorgeConsumer, _) {
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
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                ),
              ),
              Text(
                widget.coinHome.name.toString(),
                style: TextStyle(
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                coinsFireStorgeConsumer
                    .getFavorites(widget.coinHome.id.toString());
                coinsFireStorgeConsumer.isOk
                    ? {
                        coinsFireStorgeConsumer
                            .removeFaveId(widget.coinHome.id.toString()),
                        // initState(),
                        // setState(() {}),
                      }
                    : {
                        coinsFireStorgeConsumer.addToFaveId(
                            widget.coinHome.id.toString(), widget.index),
                        // initState(),
                        // setState(() {}),
                      };
              },
              icon: Icon(
                isOk ? Icons.star : Icons.star_border_outlined,
                color: mainColor,
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          color: mainColor,
          backgroundColor: themeListener.isDark
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
                            color: themeListener.isDark
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
                        color: themeListener.isDark
                            ? darkBackroundContinarColor
                            : lightBackroundBottomNavigationBarColor
                                .withOpacity(0.5),
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
                        color: themeListener.isDark
                            ? darkBackroundContinarColor
                            : lightBackroundBottomNavigationBarColor
                                .withOpacity(0.5),
                      ),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: ((context, index) => Desdetails(
                              name: listDetails[index].name,
                              number: listDetails[index].number,
                            )),
                        itemCount: listDetails.length,
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
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
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
                  color: themeListener.isDark
                      ? darkMainTextColor
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                number,
                style: TextStyle(
                  fontSize: 10,
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Divider(
            height: 1,
            color: themeListener.isDark
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
