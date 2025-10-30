import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:trendychef/Presentation/home/home.dart';
import 'package:trendychef/Presentation/widgets/pageview/pageview.dart';

void showCenterPopup(BuildContext context) {
  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder:
        (context) => Stack(
          children: [
            // Optional: Transparent barrier to block interactions
            Positioned.fill(
              child: IgnorePointer(child: Container(color: Colors.transparent)),
            ),
            Center(
              child: Lottie.asset(
                'assets/lottie/order_success.json',
                width: 350,
                height: 350,
                repeat: false,
              ),
            ),
          ],
        ),
  );

  overlay.insert(overlayEntry);

  // Remove after animation duration
  Future.delayed(const Duration(seconds: 2), () {
    overlayEntry.remove();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavScreen(child: HomePage(),)),
      (route) => false,
    );
  });
}
