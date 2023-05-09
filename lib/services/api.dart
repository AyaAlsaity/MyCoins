import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:async';
import '../helpers/consts.dart';

class Api {
  Future<Response> get(url, Map body) async {
    if (kDebugMode) {
      print("GET ON $baseUrl$url");
    }
    Response response = await http.get(Uri.parse('$baseUrl$url'));
    if (kDebugMode) {
      print("STATUS CODE :${response.statusCode}");
    }

    if (kDebugMode) {
      print("RESPONSE BODY :${response.body}");
    }
    return response;
  }

  Future<Response> post(url, Map body) async {
    Response response = await http.post(Uri.parse('$baseUrl$url'), body: body);
    return response;
  }

  Future<Response> put(url, Map body) async {
    Response response = await http.put(Uri.parse('$baseUrl$url'), body: body);
    return response;
  }

  delete(url, Map body) async {
    Response response =
        await http.delete(Uri.parse('$baseUrl$url'), body: body);
    return response;
  }
}

// class ApiClient {
//   Future<List<String>> getcurrencies() async {
//     Response response = await http.get(Uri.parse(
//         'https://api.freecurrencyapi.com/v1/latest?apikey=se4a0MRPHQCRkr6i1rZgu8bqCxDnmaWR0NTxBgzq'));
//     // http.Response res = await http.get(currencyURL);
//     if (response.statusCode == 200) {
//       var body = jsonDecode(response.body);
//       var list = body["results"];
//       List<String> currencies = (list).toList();
//       if (kDebugMode) {
//         print("STATUS CODE :${response.statusCode}");
//       }

//       if (kDebugMode) {
//         print("RESPONSE BODY :${response.body}");
//       }

//       return currencies;
//     } else {
//       throw Exception("Failed to connect to Api");
//     }
//   }

//   Future<double> getRate(String froom, String to) async {
//     final Uri rateUrl = Uri.https('free.crrconv.com', '/api/v7/convert', {
//       "apiKey": "4f6ef6f6c136f9f2e860",
//       "q": "${froom}_$to",
//       "compact": "ultra"
//     });
//     http.Response res = await http.get(rateUrl);
//     if (res.statusCode == 200) {
//       var body = jsonDecode(res.body);
//       return body["${froom}_$to"];
//     } else {
//       throw Exception("Failed to connect to Api");
//     }
//   }
// }
