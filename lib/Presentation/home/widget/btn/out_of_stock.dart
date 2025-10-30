import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Padding outOfStockBtn() {
  return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.redAccent.withOpacity(0.3),
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    "Out Of Stock",
                    style: TextStyle(color: AppColors.fontWhite),
                  ),
                ),
              ),
            );
}