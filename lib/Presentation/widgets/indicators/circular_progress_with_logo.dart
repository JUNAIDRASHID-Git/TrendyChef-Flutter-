import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';

Center circularPrgIndicatorWithLogo() {
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 60,
          height: 60,
          child: Image.asset(
            "assets/images/trendy_logo.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          width: 80, // Slightly larger than the image
          height: 80,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
        ),
      ],
    ),
  );
}
