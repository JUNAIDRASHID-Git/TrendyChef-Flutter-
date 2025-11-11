import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendychef/Presentation/home/widget/btn/cubit/cart_button_cubit_cubit.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class CartButton extends StatelessWidget {
  final String productId;
  final double productPrice;
  final VoidCallback? onSuccess;
  final String? customText;
  final double width;
  final double height;

  const CartButton({
    super.key,
    required this.productId,
    required this.productPrice,
    this.onSuccess,
    this.customText,
    this.width = 160,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return BlocProvider(
      create: (_) => CartButtonCubit(),
      child: BlocBuilder<CartButtonCubit, CartButtonState>(
        builder: (context, state) {
          final cubit = context.read<CartButtonCubit>();

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _buttonColor(state),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap:
                    () => cubit.addToCart(productId, productPrice, onSuccess),
                borderRadius: BorderRadius.circular(12),
                splashColor: Colors.white.withOpacity(0.2),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: _buildContent(lang, state),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _buttonColor(CartButtonState state) {
    switch (state) {
      case CartButtonState.success:
        return Colors.green.shade500;
      case CartButtonState.error:
        return Colors.red.shade500;
      default:
        return AppColors.primary;
    }
  }

  Widget _buildContent(AppLocalizations lang, CartButtonState state) {
    switch (state) {
      case CartButtonState.loading:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
            ),
            SizedBox(width: 8),
            Text(
              "Adding...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        );
      case CartButtonState.success:
        return _iconText("Added!", Icons.check_circle);
      case CartButtonState.error:
        return _iconText("Try Again", Icons.refresh);
      case CartButtonState.idle:
        return _iconText(
          lang.addtocart,
          Iconsax.shopping_cart,
          productPrice,
        );
    }
  }

  Widget _iconText(String text, IconData icon, [double price = 0]) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 18),
        const SizedBox(width: 10),
        if (price > 0)
          Text(
            "$price",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
        if (price > 0) ...[
          const SizedBox(width: 5),
          Image.asset(
            "assets/images/riyal_logo.png",
            color: AppColors.fontWhite,
            width: 14,
          ),
        ],
      ],
    );
  }
}
