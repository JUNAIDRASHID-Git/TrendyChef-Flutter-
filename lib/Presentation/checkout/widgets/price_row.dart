import 'package:flutter/material.dart';

Widget buildPriceRow(
  String label,
  String amount, {
  bool isTotal = false,
  bool isRiyalLogo = false,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 22 : 18,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Row(
          children: [
            Text(
              amount,
              style: TextStyle(
                fontSize: isTotal ? 22 : 18,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            SizedBox(width: 5),
            if (isRiyalLogo == true)
              Image.asset(
                "assets/images/riyal_logo.png",
                width: 14,
                height: 14,
              ),
          ],
        ),
      ],
    ),
  );
}
