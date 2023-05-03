
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../helpers/consts.dart';
// import '../models/coins_search_model.dart';

// class CoinsSearchProvider with ChangeNotifier {


//   String urlListMarket =
//       '${baseUrl}coins/markets?vs_currency=idr&order=market_cap_desc&per_page=100&page=1&sparkline=false';
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
// }