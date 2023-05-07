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

    var response = await _api
        .get('/api/v3/coins/markets?vs_currency=usd&sparkline=true', {});

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      List result = json.decode(response.body);
      final data = result.map((json) => CoinsModel.fromJson(json)).toList();
      setCoins(data);
    }
  }

  setCoins(List<CoinsModel> data) {
    coinsList = data;

    notifyListeners();
  }
}
