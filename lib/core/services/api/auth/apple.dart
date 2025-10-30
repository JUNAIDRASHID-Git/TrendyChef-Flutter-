import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/Presentation/home/home.dart';
import 'package:trendychef/Presentation/widgets/pageview/pageview.dart';
import 'package:trendychef/core/constants/const.dart';

Future<void> userAppleAuthHandler(String idToken, BuildContext context) async {
  try {
    final uri = Uri.parse(googleAuthEndpoind); // your Apple endpoint here
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'idToken': idToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      final token = data['token'];
      final email = data['email'];
      final name = data['name'];
      final picture = data['picture'];

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('email', email ?? '');
      await prefs.setString('name', name ?? '');
      await prefs.setString('picture', picture ?? '');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BottomNavScreen(child: HomePage(),)),
      );

      debugPrint('✅ Apple Authentication successful: $data');
    } else {
      final error = response.body;
      debugPrint(
        '❌ Apple Authentication failed: ${response.statusCode}, $error',
      );
      throw Exception(error);
    }
  } catch (e) {
    debugPrint('❌ Error during Apple authentication: $e');
    throw Exception(e.toString());
  }
}
