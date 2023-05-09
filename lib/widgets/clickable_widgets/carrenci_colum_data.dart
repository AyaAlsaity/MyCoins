import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/coins_provider.dart';
import '../../providers/dark_theme_provider.dart';
import '../../screen/sub_screens/details_screen.dart';

class CarrenciColumData extends StatefulWidget {
  const CarrenciColumData({
    Key? key,
  }) : super(key: key);

  @override
  State<CarrenciColumData> createState() => _CarrenciColumDataState();
}

class _CarrenciColumDataState extends State<CarrenciColumData> {
  @override
  Widget build(BuildContext context) {
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final double width = MediaQuery.of(context).size.width;
    return Consumer<CoinsProvider>(builder: (context, coinsConsumer, _) {
      return DataTable(
          dividerThickness: 1.5,
          dataRowHeight: 60,
          columnSpacing: 2,
          horizontalMargin: 0,
          columns: [
            DataColumn(
                label: Row(
              children: [
                SizedBox(
                    width: width * .1,
                    child: Text(
                      "#",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: themeListener.isDark
                            ? darktitleColor
                            : mainTextColor,
                        fontSize: 14,
                      ),
                    )),
              ],
            )),
            DataColumn(
                label: Row(
              children: [
                Container(
                  width: width * 0.2,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.coin,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )),
            DataColumn(
                label: Row(
              children: [
                Container(
                  width: width * .29,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.price,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )),
            DataColumn(
                label: Row(
              children: [
                Container(
                  width: width * .25,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.hour,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )),
            DataColumn(
                label: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: width * .45,
                  alignment: Alignment.center,
                  child: Text(
                    AppLocalizations.of(context)!.market,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )),
          ],
          rows: List<DataRow>.generate(coinsConsumer.coinsList.length, (i) {
            return DataRow(cells: <DataCell>[
              DataCell(Container(
                alignment: Alignment.center,
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 11,
                  ),
                ),
              )),
              DataCell(GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => DetailsScreen(
                                coinHome: coinsConsumer.coinsList[i],
                                index: i,
                              )));
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child:ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                              coinsConsumer.coinsList[i].image.toString()),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        coinsConsumer.coinsList[i].symbol.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: themeListener.isDark
                              ? darktitleColor
                              : mainTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              DataCell(Container(
                width: 110,
                alignment: Alignment.center,
                child: Text(
                  "\$ ${coinsConsumer.coinsList[i].currentPrice.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 12,
                  ),
                ),
              )),
              DataCell(Container(
                alignment: Alignment.center,
                child: Row(
                  children: [
                    const Icon(Icons.arrow_drop_down,
                        size: 20, color: Colors.red),
                    Text(
                      coinsConsumer.coinsList[i].priceChangePercentage24H
                          .toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: themeListener.isDark
                            ? darktitleColor
                            : mainTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )),
              DataCell(Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  width: 140,
                  child: Text(
                    coinsConsumer.coinsList[i].marketCap.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              )),
            ]);
          }));
    });
  }
}

// class SmallCarrenciCard extends StatefulWidget {
//   const SmallCarrenciCard(
//       {super.key,
//       required this.image,
//       required this.name,
//       required this.price,
//       required this.symbol});

//   final String image;
//   final String name;
//   final String price;
//   final String symbol;
//   @override
//   State<SmallCarrenciCard> createState() => _SmallCarrenciCardState();
// }

// class _SmallCarrenciCardState extends State<SmallCarrenciCard> {

//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Column(
//       children: [
//         Row(
//           children: [
//             SizedBox(width: 40, height: 46, child: Image.network(widget.image)),
//             const SizedBox(
//               width: 12,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               // crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.name,
//                   style: TextStyle(
//                     color:
//                         themeListener.isDark ? darktitleColor : mainTextColor,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   widget.symbol,
//                   style: const TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Row(
//               children: [
//                 Text(
//                   widget.price,
//                   style: TextStyle(
//                     color:
//                         themeListener.isDark ? darktitleColor : mainTextColor,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(
//                   width: 6,
//                 ),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: themeListener.isDark ? green : softGreen,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(8),
//                     ),
//                   ),
//                   child: SizedBox(
//                     height: 25,
//                     width: 30,
//                     child: Center(
//                       child: Text(
//                         '+21%',
//                         style: TextStyle(
//                             color: themeListener.isDark ? softGreen : green,
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         const SizedBox(
//           height: sizedBoxSameComponents,
//         )
//       ],
//     );
//   }
// }

// class MyImageTextWidget extends StatelessWidget {
//   MyImageTextWidget({super.key, required this.coinsModel});
//   CoinsModel coinsModel;

//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Container(
//       alignment: Alignment.center,
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Container(
//             width: 20,
//             height: 20,
//             decoration: BoxDecoration(
//                 color: Colors.grey, borderRadius: BorderRadius.circular(20)),
//             child: Image.network(coinsModel.image
//                 // 'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579'
//                 ),
//           ),
//           const SizedBox(
//             height: 4,
//           ),
//           Text(
//             coinsModel.symbol,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: themeListener.isDark ? darktitleColor : mainTextColor,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyIconTextWidget extends StatelessWidget {
//   MyIconTextWidget({super.key, required this.coinsModel});
//   CoinsModel coinsModel;

//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Container(
//       alignment: Alignment.center,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           const Icon(Icons.arrow_drop_down, size: 20, color: Colors.red),
//           Text(
//             coinsModel.priceChangePercentage24H.toString(),
//             // '2.4%',
//             textAlign: TextAlign.right,
//             style: TextStyle(
//               fontWeight: FontWeight.w500,
//               color: themeListener.isDark ? darktitleColor : mainTextColor,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
