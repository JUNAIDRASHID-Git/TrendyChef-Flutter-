import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class CheckoutButton extends StatefulWidget {
  final CartLoaded state;

  const CheckoutButton({super.key, required this.state});

  @override
  State<CheckoutButton> createState() => _CheckoutButtonState();
}

class _CheckoutButtonState extends State<CheckoutButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _wiggleAnimation;

  @override
  void initState() {
    super.initState();

    // Create animation controller
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    // Create wiggle animation (left-right movement)
    _wiggleAnimation = Tween<double>(begin: -5.0, end: 3.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut),
    );

    // Start the repeating animation
    _startWiggleAnimation();
  }

  void _startWiggleAnimation() {
    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 110),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.orangeColor,
          minimumSize: const Size(150, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () {
          context.go("/checkout");
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.state.items.length} ${lang.items}',
                    style: TextStyle(
                      color: AppColors.fontWhite.withOpacity(0.9),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/riyal_logo.png",
                        color: AppColors.fontWhite,
                        width: 22,
                        height: 22,
                      ),
                      Text(
                        ' ${widget.state.totalAmount.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.fontWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              lang.checkout.toUpperCase(),
              style: TextStyle(
                letterSpacing: 1,
                fontSize: 22,
                fontFamily: "Poppins",
                color: AppColors.fontWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Animated Arrow Container
            AnimatedBuilder(
              animation: _wiggleAnimation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(_wiggleAnimation.value, 0),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.fontWhite,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.arrow_forward_sharp,
                      size: 30,
                      color: AppColors.primary,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
