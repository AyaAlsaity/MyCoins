import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycoins/models/coins_search_model.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../models/coins_model.dart';
import '../../models/details_map.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/chartWidget.dart';
import '../../widgets/static_widgets/continarDarkmode.dart';
import '../../widgets/static_widgets/money_converter_widget.dart';

import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'search_screen.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.coin}) : super(key: key);
  final CoinsearchModel coin;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isOk1 = false;
  bool isLoading = true;
  bool isFirstTime = true;
  List<FlSpot> flSpotList = [];
  double minX = 0;
  double minY = 0;
  double maxX = 0;
  double maxY = 0;

  void getChartData(String days) async {
    if (isFirstTime) {
      isFirstTime = false;
    } else {
      setState(() {
        isLoading = true;
      });
    }
    String api =
        'https://api.coingecko.com/api/v3/coins/${widget.coin.id}/market_chart?vs_currency=idr&days=$days';
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
  }

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
               widget.coin.image.toString(),
                width: 25,
                height: 25,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              widget.coin.symbol.toString().toUpperCase(),
              style: TextStyle(
                fontSize: 14,
                color: themeFunctions.isDark ? darktitleColor : mainTextColor,
              ),
            ),
            Text(

              widget.coin.name.toString(),
              style: TextStyle(
                  color: themeFunctions.isDark ? darktitleColor : mainTextColor,
                  fontWeight: FontWeight.bold),
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
              isOk1 ? Icons.star : Icons.star_border_outlined,
              color: mainColor,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const moneyConverter())); },
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
            child:SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Row(
                  
                    children: [
                      Text(
                        '\$ ${widget.coin.currentPrice.toString()}',
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
                       Text(
                         '${widget.coin.priceChangePercentage24h} %',
                        style: const TextStyle(color: warningColor),
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
                            widget.coin.image.toString(),
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
                
                       
                         isLoading == false
          ?Container(
              width: size.width,
                            height: size.width/1.5,
                                  decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(paddingAll),
                              color: themeFunctions.isDark
                                  ? darkBackroundContinarColor
                                  : secondeyTextColor,
                            ),
                              child: Column(
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () => getChartData('1'),
                              child: Container(
                                      decoration: BoxDecoration(
                                          color: mainColor.withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
                                          color: mainColor.withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
                                          color: mainColor.withOpacity(0.8), borderRadius: BorderRadius.circular(10)),
                                      child: const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
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
                        )
                  , const SizedBox(
                    height: sizedBoxNotSameComponents,
                  ),


              ],
            ),
          ) :const Center(child: CircularProgressIndicator()),
            const SizedBox(
                    height: sizedBoxNotSameComponents+10,
                  ),
                                    Container(
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
                                                          fontSize: 12,
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
                                            )
                                            ),
                                            ),
                                            ),
                      ],
                    ),
                  ),
                ),
            ),
          ),
         
    );
  }
}

class PriceAndTime {
  late int time;
  late double price;

  PriceAndTime({required this.time, required this.price});
}








// class DetailsScreen extends StatefulWidget {
//   const DetailsScreen({super.key,
//   //  required this.coin
//    });



//   @override
//   Widget build(BuildContext context) {



//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
