import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/category.dart';
import 'package:trendychef/core/services/models/product.dart';

Future<List<ProductModel>> getAllProducts() async {
  final uri = Uri.parse(userProductsEndpoint);
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

Future<ProductModel> getProductByID({required String productID}) async {
  final uri = Uri.parse("$userProductsEndpoint/$productID"); // Correct URI
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null) {
    debugPrint("❌ No token found");
    throw Exception("Authentication token not found.");
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
      log("Product data fetched");

      // Assuming response body contains a single product JSON, decode it into a ProductModel
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final product = ProductModel.fromJson(
        jsonData,
      ); // Return the single product model

      return product;
    } else {
      throw Exception(
        "Failed to fetch the product. Status Code: ${response.statusCode}",
      );
    }
  } catch (e) {
    log("Error fetching product: $e");
    rethrow; // Rethrow the caught error for higher-level handling
  }
}

Future<List<CategoryModel>> getAllCategoryWithProducts() async {
  final uri = Uri.parse(userCategoryProductsEndpoint);
  final pref = await SharedPreferences.getInstance();
  final token = pref.getString("token");

  if (token == null || token.isEmpty) {
    debugPrint("❌ No token found");
    return <CategoryModel>[];
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
      log("✅ Categories with products fetched");
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      log("❌ Server responded with ${response.statusCode}: ${response.body}");
      throw Exception("Failed to fetch category data");
    }
  } catch (e) {
    log("❌ Error fetching category data: $e");
    rethrow;
  }
}
