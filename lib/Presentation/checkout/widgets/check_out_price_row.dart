import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/Presentation/checkout/widgets/price_row.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class CheckoutPriceDetails extends StatelessWidget {
  final CheckOutLoaded state;
  final bool showShipping; // 👈 New flag

  const CheckoutPriceDetails({
    super.key,
    required this.state,
    this.showShipping = true, // default is true (old behavior)
  });

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.fontWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Coupon Field
          TextFormField(
            decoration: InputDecoration(
              hintText: "Coupon Code (Coming Soon)",
              prefixIcon: const Icon(Icons.local_offer, size: 18),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),

          const SizedBox(height: 16),

          buildPriceRow(
            lang.items,
            state.items.length.toString(),
            isTotal: false,
          ),

          buildPriceRow(
            lang.shippingcost,
            state.shippingCost.toString(),
            isTotal: true,
            isRiyalLogo: true,
          ),

          // ✅ Always show subtotal
          buildPriceRow(
            lang.subtotal,
            state.totalAmount.toStringAsFixed(2),
            isTotal: true,
            isRiyalLogo: true,
          ),
        ],
      ),
    );
  }
}
