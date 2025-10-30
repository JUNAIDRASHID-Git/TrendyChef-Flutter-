import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Container productDetailsContainer({
  required String title,
  required String subTitle,
}) {
  return Container(
    padding: EdgeInsets.all(10),
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins",
            color: AppColors.fontBlack,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Text(subTitle),
      ],
    ),
  );
}
