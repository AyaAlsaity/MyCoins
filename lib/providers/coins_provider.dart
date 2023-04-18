import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/coins_model.dart';
import '../services/api.dart';



class GamesProvider with ChangeNotifier {
  bool isLoading = false;
  bool isFailed = false;

  List<CoinsModel> gamesList = [];

  final _api = Api();

  getGames() async {
    isLoading = true;
    
         var response = await _api.get('/api/v3/coins/markets?vs_currency=usd&sparkline=true',
        {});
     

    if (response.statusCode == 200) {
      var rawData = json.decode(response.body);
      setGames(rawData);
    }
  }

  setGames(jsonData) {
    gamesList.clear();
    isLoading = false;

    for (var i in jsonData) {
      gamesList.add(CoinsModel.fromJson(i));
    }

    notifyListeners();
  }
}