import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/checkout/bloc/check_out_bloc.dart';
import 'package:trendychef/Presentation/checkout/widgets/check_out_price_row.dart';
import 'package:trendychef/Presentation/widgets/address_row/address_row_container.dart';
import 'package:trendychef/Presentation/widgets/address_row/bloc/address_bloc.dart';
import 'package:trendychef/Presentation/widgets/buttons/paymentBtn/payment_btn.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/Presentation/widgets/product/expandable_product_list_view.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/models/payment.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckOutBloc()..add(CheckOutFetchEvent()),
        ),
        BlocProvider(
          create: (context) => AddressBloc()..add(FetchAddressEvent()),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.fontWhite,
        appBar: AppBar(
          backgroundColor: AppColors.fontWhite,
          title: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 1200,
              ), // ✅ same as body
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      context.go("/cart");
                    },
                    icon: Icon(Icons.arrow_back, color: AppColors.primary),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    lang.checkout,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Poppins",
                      letterSpacing: lang.localeName == "en" ? 5 : 0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            // ✅ this makes the constrained box stay centered
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1200),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: BlocBuilder<CheckOutBloc, CheckOutState>(
                  builder: (context, state) {
                    if (state is CheckOutLoading) {
                      return circularPrgIndicatorWithLogo();
                    } else if (state is CheckOutError) {
                      return Center(child: Text("Error: //${state.message}"));
                    } else if (state is CheckOutLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ExpandableAddressRow(),
                          const SizedBox(height: 5),
                          ExpandableProductList(state: state),
                          const SizedBox(height: 10),
                          CheckoutPriceDetails(state: state),
                          const SizedBox(height: 20),
                          PaymentBtn(
                            payment: PaymentModel(
                              cartid: state.items[0].cartId.toString(),
                              amount: state.totalAmount + state.shippingCost,
                              currency: "SAR",
                              description:
                                  "Payment for ${state.items.length} items",
                              name: state.user.name,
                              email: state.user.email ?? "user@gmail.com",
                              phone: state.user.phone,
                              addressLine1: state.user.address.street,
                              city: state.user.address.city,
                              region: state.user.address.state,
                              postcode: state.user.address.postalCode,
                            ),
                            shippingCost: state.shippingCost,
                          ),
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
