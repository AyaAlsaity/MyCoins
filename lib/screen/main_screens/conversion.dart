import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mycoins/models/coins_search_model.dart';

import 'package:provider/provider.dart';
import '../../helpers/consts.dart';
import '../../providers/dark_theme_provider.dart';
import '../../widgets/static_widgets/appBar_widget.dart';
import '../../widgets/static_widgets/drawer_widgets/custom_drawer.dart';
import '../sub_screens/details_screen.dart';
import '../sub_screens/search_screen.dart';

class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  @override
  Widget build(BuildContext context) {
        Size size = MediaQuery.of(context).size;
    final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBarWidget(context),
      drawer: const CustomDrawer(),
      body:  const Text("Conversion Screen"),
    );
  }
}

// class CoinSearchScreen extends StatefulWidget {
//   const CoinSearchScreen({Key? key}) : super(key: key);

//   @override
//   State<CoinSearchScreen> createState() => _CoinSearchScreenState();
// }

// class _CoinSearchScreenState extends State<CoinSearchScreen> {
//   String urlListMarket =
//       'https://api.coingecko.com/api/v3/coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1&sparkline=false';
//   List<CoinsearchModel> listCoin = [];
//   late Future<List<CoinsearchModel>> listCoinFuture;
//   bool isFirstTimeDataAccess = true;

//   Future<List<CoinsearchModel>> getListCoins() async {
//     final response = await http.get(Uri.parse(urlListMarket));
//     if (response.statusCode == 200) {
//       List result = json.decode(response.body);
//       final data =
//           result.map((json) => CoinsearchModel.fromJson(json)).toList();
//       return data;
//     } else {
//       return <CoinsearchModel>[];
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     listCoinFuture = getListCoins();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Scaffold(
//       appBar: AppBar(
//           //   centerTitle: true,
//           //   systemOverlayStyle: const SystemUiOverlayStyle(
//           //     statusBarColor: darkBackroundScreenColor,
//           //   ),
//           //   title: const Text(
//           //     "My Coins",
//           //     style: TextStyle(
//           //         color: mainColor, fontSize: 24, fontWeight: FontWeight.w600),
//           //   ),
//           ),
//       // drawer: const CustomDrawer(),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: SizedBox(
//           width: double.infinity,
//           child: FutureBuilder(
//             future: listCoinFuture,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 if (isFirstTimeDataAccess) {
//                   listCoin = snapshot.data!;
//                   isFirstTimeDataAccess = false;
//                 }

//                 return Column(
//                   children: [
//                     TextField(
//                       onChanged: (query) {
//                         List<CoinsearchModel> searchResult =
//                             snapshot.data!.where((coin) {
//                           String name = coin.name!.toLowerCase();
//                           bool isFound = name.contains(query);
//                           return isFound;
//                         }).toList();
//                         setState(() {
//                           listCoin = searchResult;
//                         });
//                       },
//                       decoration: InputDecoration(
//                           prefixIcon: const Icon(
//                             Icons.search,
//                             color: mainColor,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: themeListener.isDark
//                                     ? darktitleColor
//                                     : mainTextColor,
//                               )),
//                           focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: const BorderSide(color: mainColor)),
//                           border: OutlineInputBorder(
//                             borderSide: const BorderSide(color: mainColor),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           hintText: 'Search coins',
//                           hintStyle: TextStyle(
//                             color: themeListener.isDark
//                                 ? darktitleColor
//                                 : mainTextColor,
//                           )),
//                     ),
//                     const SizedBox(height: 24),
//                     Expanded(
//                       child: listCoin.isEmpty
//                           ? const Center(
//                               child: Text('No Coin Found'),
//                             )
//                           : ListView.separated(
//                               itemCount: listCoin.length,
//                               itemBuilder: (context, index) {
//                                 return _buildCoin(listCoin[index]);
//                               },
//                               separatorBuilder: (context, index) =>
//                                   const Divider(
//                                 color: greyColor,
//                               ),
//                             ),
//                     ),
//                   ],
//                 );
//               } else if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else {
//                 return const Center(child: Text('Error Occurred'));
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }

//   Padding _buildCoin(CoinsearchModel coin) {
//     final themeListener = Provider.of<DarkThemeProvider>(context, listen: true);
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: ListTile(
//         onTap: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const DetailsScreen()));
//         },
//         leading: Image.network(
//           coin.image ?? '',
//           width: 50,
//           height: 50,
//         ),
//         title: Text(
//           coin.name ?? '',
//           style: TextStyle(
//             color: themeListener.isDark ? darktitleColor : mainTextColor,
//           ),
//         ),
//         trailing: Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             Text(
//               CurrencyHelper.idr(coin.currentPrice!),
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: themeListener.isDark ? darktitleColor : mainTextColor,
//               ),
//             ),
//             const SizedBox(height: 5),
//             Text(
//               '${coin.priceChangePercentage24h} %',
//               style: const TextStyle(color: successColor),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Drawer _buildDrawer() {
//     return Drawer(
//       child: ListView(
//         children: [
//           DrawerHeader(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: const [
//                 CircleAvatar(
//                   radius: 25,
//                   backgroundImage: NetworkImage(
//                       'https://avatars.githubusercontent.com/u/33564447?v=4'),
//                 ),
//                 SizedBox(height: 12),
//                 Text('Fikky Ardianto'),
//                 Text('fikky@gmail.com'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CurrencyHelper {
//   static String idr(double number) {
//     NumberFormat currencyFormatter = NumberFormat.currency(
//       locale: 'id',
//       symbol: 'Rp. ',
//       decimalDigits: 0,
//     );
//     return currencyFormatter.format(number);
//   }
// }
