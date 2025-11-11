import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_bloc.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_event.dart';
import 'package:trendychef/Presentation/cart/bloc/cart_state.dart';
import 'package:trendychef/Presentation/cart/widgets/cart_card_builder.dart';
import 'package:trendychef/Presentation/cart/widgets/check_out_btn.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      body: BlocProvider(
        create: (_) => CartBloc()..add(LoadCartItems()),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return circularPrgIndicatorWithLogo();
            } else if (state is CartLoaded) {
              if (state.items.isEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 350,
                          child: LottieBuilder.asset(
                            "assets/lottie/empty_cart.json",
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Main text with styling
                            Text(
                              lang.cartemptymessage,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: AppColors.fontBlack.withOpacity(0.7),
                              ),
                            ),

                            const SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 100),
                      ],
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  CartCardList(state: state),
                  CheckoutButton(state: state),
                ],
              );
            } else if (state is CartError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
