import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/user_model.dart';

Future<bool> updateUser(UserModel user) async {
  final url = Uri.parse(userEndpoint);
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null) {
    debugPrint("❌ No token found");
    return false;
  }

  try {
    final response = await http.put(
      url,
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      if (kDebugMode) {
        print("Update failed: ${response.body}");
      }
      return false;
    }
  } catch (e) {
    if (kDebugMode) {
      print("Exception during update: $e");
    }
    return false;
  }
}
