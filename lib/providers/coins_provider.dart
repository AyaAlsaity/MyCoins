import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/coins_model.dart';
import '../services/api.dart';

class CoinsProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;

  List<CoinsModel> coinsList = [];

  final _api = Api();

  getCoins() async {
    isLoading = true;

    var response =
        await _api.get('coins/markets?vs_currency=usd&sparkline=true', {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setCoins(rawData);
    }
  }

  setCoins(jsonData) {
    coinsList.clear();
    isLoading = false;

    for (var i in jsonData) {
      coinsList.add(CoinsModel.fromJson(i));
    }

    notifyListeners();
  }
}
