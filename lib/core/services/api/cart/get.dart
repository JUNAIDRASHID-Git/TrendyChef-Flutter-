import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/cart.dart';

Future<List<CartItemModel>> fetchCartItems() async {
  final uri = Uri.parse(userCartEndpoint);
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null) {
    debugPrint("❌ No token found");
    return [];
  }

  final response = await http.get(
    uri,
    headers: {"Authorization": token, 'Content-Type': 'application/json'},
  );
  if (response.statusCode == 200) {
    final List jsonData = json.decode(response.body);
    return jsonData.map((e) => CartItemModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load cart items');
  }
}
