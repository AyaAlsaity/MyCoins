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


