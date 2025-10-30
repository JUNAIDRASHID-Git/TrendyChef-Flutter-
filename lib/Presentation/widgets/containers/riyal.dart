import 'package:flutter/material.dart';

Widget riyalLogo({double? width, double? opacity,Color? color}) {
  return Opacity(
    opacity: opacity ?? 1.0,
    child: Image.asset("assets/images/riyal_logo.png", width: width,color: color,),
  );
}
