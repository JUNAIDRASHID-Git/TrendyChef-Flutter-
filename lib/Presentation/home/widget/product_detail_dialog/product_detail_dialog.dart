// ProductDialogPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/product/pages/bloc/product_bloc.dart';
import 'package:trendychef/Presentation/product/widgets/image_container.dart';
import 'package:trendychef/Presentation/product/widgets/price_container.dart';
import 'package:trendychef/Presentation/product/widgets/product_details_container.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class ProductDialogPage extends StatelessWidget {
  final String productID;
  const ProductDialogPage({super.key, required this.productID});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: 100),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        color: AppColors.fontWhite,
        child: BlocProvider(
          create:
              (context) =>
                  ProductBloc()..add(GetProductEvent(productID: productID)),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: circularPrgIndicatorWithLogo());
              } else if (state is ProductError) {
                return const Center(
                  child: Text("Failed to fetch product details"),
                );
              } else if (state is ProductLoaded) {
                final product = state.product;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, color: Colors.black54),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Hero(
                                  tag: "product_${product.id}",
                                  child: productImageContainer(
                                    product: product,
                                    context: context,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              productDetailsContainer(
                                title:
                                    lang.localeName == "en"
                                        ? product.eName
                                        : product.arName ?? "",
                                subTitle:
                                    lang.localeName == "en"
                                        ? product.eDescription ?? ""
                                        : product.arDescription ?? "",
                              ),
                              const SizedBox(height: 16),
                              priceContainer(
                                salePrice: product.salePrice,
                                regularPrice: product.regularPrice,
                                productID: product.id.toString(),
                                productStock: product.stock,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
