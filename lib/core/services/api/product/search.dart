import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/product.dart';

Future<List<ProductModel>> searchProduct(String searchData) async {
  final uri = Uri.parse("$userProductsEndpoint?search=$searchData");
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null) {
    debugPrint("❌ No token found");
    return <ProductModel>[];
  }

  try {
    final response = await http.get(
      uri,
      headers: {
        "Authorization": token,
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      log("Products data fetched");
      final List<dynamic> jsonData = json.decode(response.body);
      final products = jsonData.map((e) => ProductModel.fromJson(e)).toList();
      return products.toList();
    } else {
      throw Exception("failed to fetch the product");
    }
  } catch (e) {
    log("Error fetching Products: $e");
    rethrow;
  }
}
