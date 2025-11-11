import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/product/pages/bloc/product_bloc.dart';
import 'package:trendychef/Presentation/product/widgets/image_container.dart';
import 'package:trendychef/Presentation/product/widgets/price_container.dart';
import 'package:trendychef/Presentation/product/widgets/product_details_container.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class Productpage extends StatelessWidget {
  final String productID;
  const Productpage({super.key, required this.productID});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      appBar: AppBar(
        backgroundColor: AppColors.fontWhite,
        leading: IconButton(
          onPressed: () {
            context.go("/shop");
          },
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: AppColors.primary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocProvider(
          create:
              (context) =>
                  ProductBloc()..add(GetProductEvent(productID: productID)),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(child: circularPrgIndicatorWithLogo());
              } else if (state is ProductError) {
                return Center(
                  child: Text(
                    "Failed to Fetch Product Details \n OR \n this Product is no more",
                  ),
                );
              } else if (state is ProductLoaded) {
                final product = state.product;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 600;

                    return SingleChildScrollView(
                      padding: const EdgeInsets.all(10),
                      child: Hero(
                        tag: "product_${product.id}",
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            if (isWide)
                              // For tablets or wide screens: Row layout
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: productImageContainer(
                                        product: product,
                                        context: context,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: [
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
                                        SizedBox(height: 10),
                                        priceContainer(
                                          salePrice: product.salePrice,
                                          regularPrice: product.regularPrice,
                                          productID: product.id.toString(),
                                          productStock: product.stock,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            else
                              // For mobile: Column layout
                              Column(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 1,
                                    child: productImageContainer(
                                      product: product,
                                      context: context,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
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
                                  SizedBox(height: 10),
                                  priceContainer(
                                    salePrice: product.salePrice,
                                    regularPrice: product.regularPrice,
                                    productID: product.id.toString(),
                                    productStock: product.stock,
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
