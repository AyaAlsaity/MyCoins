// To parse this JSON data, do

//     final coinsModel = coinsModelFromJson(jsonString);

import 'dart:convert';

class CoinsModel {
  String id;
  String symbol;
  String name;
  String image;
  double currentPrice;
  String marketCap;
  String marketCapRank;
  String fullyDilutedValuation;
  String totalVolume;
  String high24H;
  String low24H;
  String priceChange24H;
  String priceChangePercentage24H;
  String marketCapChange24H;
  String marketCapChangePercentage24H;
  String circulatingSupply;
  String totalSupply;
  String maxSupply;
  String ath;
  String athChangePercentage;

  CoinsModel({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.fullyDilutedValuation,
    required this.totalVolume,
    required this.high24H,
    required this.low24H,
    required this.priceChange24H,
    required this.priceChangePercentage24H,
    required this.marketCapChange24H,
    required this.marketCapChangePercentage24H,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.maxSupply,
    required this.ath,
    required this.athChangePercentage,
  });

  factory CoinsModel.fromRawJson(String str) =>
      CoinsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoinsModel.fromJson(Map<String, dynamic> json) => CoinsModel(
        id: json["id"],
        symbol: json["symbol"],
        name: json["name"],
        image: json["image"],
        currentPrice: double.parse(json["current_price"].toString()),
        marketCap: json["market_cap"].toString(),
        marketCapRank: json["market_cap_rank"].toString(),
        fullyDilutedValuation: json["fully_diluted_valuation"].toString(),
        totalVolume: json["total_volume"].toString(),
        high24H: json["high_24h"].toString(),
        low24H: json["low_24h"].toString(),
        priceChange24H: json["price_change_24h"].toString(),
        priceChangePercentage24H:
            json["price_change_percentage_24h"].toString(),
        marketCapChange24H: json["market_cap_change_24h"].toString(),
        marketCapChangePercentage24H:
            json["market_cap_change_percentage_24h"].toString(),
        circulatingSupply: json["circulating_supply"].toString(),
        totalSupply: json["total_supply"].toString(),
        maxSupply: json["max_supply"].toString(),
        ath: json["ath"].toString(),
        athChangePercentage: json["ath_change_percentage"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "symbol": symbol,
        "name": name,
        "image": image,
        "current_price": currentPrice,
        "market_cap": marketCap,
        "market_cap_rank": marketCapRank,
        "fully_diluted_valuation": fullyDilutedValuation,
        "total_volume": totalVolume,
        "high_24h": high24H,
        "low_24h": low24H,
        "price_change_24h": priceChange24H,
        "price_change_percentage_24h": priceChangePercentage24H,
        "market_cap_change_24h": marketCapChange24H,
        "market_cap_change_percentage_24h": marketCapChangePercentage24H,
        "circulating_supply": circulatingSupply,
        "total_supply": totalSupply,
        "max_supply": maxSupply,
        "ath": ath,
        "ath_change_percentage": athChangePercentage,
      };
}
