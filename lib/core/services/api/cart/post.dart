import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';

Future<void> postCart({
  required String productId,
  required int quantity,
}) async {
  final uri = Uri.parse(userCartEndpoint);
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  debugPrint("🔍 Posting to: $uri"); // Add this line

  if (token == null) {
    debugPrint("❌ No token found");
    return;
  }

  try {
    final response = await http.post(
      uri,
      headers: {"Authorization": token, 'Content-Type': 'application/json'},
      body: jsonEncode({"product_id": productId, "quantity": quantity}),
    );

    debugPrint("📊 Response status: ${response.statusCode}"); // Add this line
    debugPrint("📊 Response headers: ${response.headers}"); // Add this line

    if (response.statusCode == 201 || response.statusCode == 200) {
      log("✅ Successfully Carted Product ${response.body}");
    } else {
      log(
        "❌ Failed to post cart: ${response.statusCode}, Body: ${response.body}",
      );
    }
  } catch (e) {
    log("❌ Error while posting cart: $e");
    rethrow;
  }
}
