import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/banner.dart';

Future<List<BannerModel>> fetchBanner() async {
  final uri = Uri.parse("$baseHost/admin/banner/");
  final response = await http.get(
    uri,
    headers: {'Content-Type': 'application/json', "X-API-KEY": apiKey},
  );

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => BannerModel.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load banners');
  }
}
