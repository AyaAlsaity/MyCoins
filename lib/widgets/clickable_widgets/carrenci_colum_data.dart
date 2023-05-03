import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../screen/sub_screens/details_screen.dart';

class CarrenciColumData extends StatefulWidget {
  const CarrenciColumData({super.key});

  @override
  State<CarrenciColumData> createState() => _CarrenciColumDataState();
}

class _CarrenciColumDataState extends State<CarrenciColumData> {
  @override
  Widget build(BuildContext context) {
    // final CoinsearchModel coin;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    final double width = MediaQuery.of(context).size.width;
    return DataTable(
        dividerThickness: 2,
        dataRowHeight: 60,
        columnSpacing: 2,
        horizontalMargin: 0,
        columns: [
          DataColumn(
              label: Row(
            children: [
              SizedBox(
                  width: width * .1,
                  //  width: 8,
                  child: Text(
                    "#",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 16,
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
                  "Coin",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
          DataColumn(
              label: Row(
            children: [
              Container(
                width: width * .2,
                alignment: Alignment.center,
                child: Text(
                  "Price",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
          DataColumn(
              label: Row(
            children: [
              Container(
                width: width * .2,
                alignment: Alignment.center,
                child: Text(
                  "24H",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 16,
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
                width: width * .4,
                alignment: Alignment.center,
                child: Text(
                  "Market Cap",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color:
                        themeListener.isDark ? darktitleColor : mainTextColor,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          )),
        ],
        rows: List<DataRow>.generate(10, (i) {
          return DataRow(cells: <DataCell>[
            DataCell(Container(
              alignment: Alignment.center,
              child: Text(
                '${i + 1}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                  fontSize: 11,
                ),
              ),
            )),
            DataCell(GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const DetailsScreen(
                            // coin: coin,
                            )));
              },
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
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
                      child: Image.network(
                          'https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579'),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'BTC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: themeListener.isDark
                            ? darktitleColor
                            : mainTextColor,
                        fontSize: 16,
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
                '\$24,000.00',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                  fontSize: 16,
                ),
              ),
            )),
            DataCell(Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(Icons.arrow_drop_down,
                      size: 20, color: Colors.red),
                  Text(
                    '2.4%',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color:
                          themeListener.isDark ? darktitleColor : mainTextColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            )),
            DataCell(SizedBox(
              width: 110,
              // padding: const EdgeInsets.only(right: 20),
              // alignment: Alignment.centerRight,
              child: Text(
                '\$200,000',
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: themeListener.isDark ? darktitleColor : mainTextColor,
                  fontSize: 16,
                ),
              ),
            )),
          ]);
        }));
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