import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/payment.dart';

Future<String?> initPayment({required PaymentModel payment}) async {
  try {
    final response = await http.post(
      Uri.parse("$baseHost/payment/place"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(payment.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["payment_url"] as String?;
    } else {
      if (kDebugMode) {
        print("Payment API error: ${response.statusCode} - ${response.body}");
      }
      return null;
    }
  } catch (e) {
    if (kDebugMode) {
      print("Payment init error: $e");
    }
    return null;
  }
}
