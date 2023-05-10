import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/coins_model.dart';
import '../models/currency_model.dart';
import '../services/api.dart';

class CoinsProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;

  List<CoinsModel> coinsList = [];

  final _api = Api();

// ///////////////////////////////////// ===>>>>>> go to FireStorgeProvoder

  List<CurrencyModel> currencies1 = [
    CurrencyModel(
      id: 1,
      name: 'USD',
      price: 5.14,
    ),
    CurrencyModel(
      id: 2,
      name: 'EUR',
      price: 5.35,
    ),
    CurrencyModel(
      id: 3,
      name: 'LTK',
      price: 1.25,
    ),
  ];

  CurrencyModel? selectedcurrenc1;
  CoinsModel? selectedcurrenc2;

// //////////////////////////////////////

  setSelectedCurrencyOne(CurrencyModel? currency) {
    selectedcurrenc1 = currency;
    notifyListeners();
  }

  setSelectedCoinTwo(CoinsModel? coinsModel) {
    selectedcurrenc2 = coinsModel;
    notifyListeners();
  }

  getCoins() async {
    isLoading = true;

    var response = await _api
        .get('/api/v3/coins/markets?vs_currency=usd&sparkline=true', {});

    if (response.statusCode == 200) {
      List result = json.decode(response.body);
      final data = result.map((json) => CoinsModel.fromJson(json)).toList();
      setCoins(data);
    }
  }

  setCoins(List<CoinsModel> data) {
    coinsList = data;
    isLoading = false;
    notifyListeners();
  }
}
