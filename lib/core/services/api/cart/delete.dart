import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';

Future<void> deleteCartItem(int itemId) async {
  final uri = Uri.parse('$userCartEndpoint$itemId');
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null) {
    debugPrint("❌ No token found");
    return;
  }
  try {
    final response = await http.delete(
      uri,
      headers: {"Authorization": token, 'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      debugPrint("✅ Cart item deleted successfully");
    } else {
      debugPrint("❌ Failed to delete cart item: ${response.body}");
    }
  } catch (e) {
    debugPrint("❌ Error deleting cart item: $e");
  }
}
