// To parse this JSON data, do
//
//     final currencyModel = currencyModelFromJson(jsonString);

import 'dart:convert';

class CurrencyModel {
  int id;
  String name;
  double price;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory CurrencyModel.fromRawJson(String str) =>
      CurrencyModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CurrencyModel.fromJson(Map<String, dynamic> json) => CurrencyModel(
        id: json["id"],
        name: json["name"],
        price: json["price"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
