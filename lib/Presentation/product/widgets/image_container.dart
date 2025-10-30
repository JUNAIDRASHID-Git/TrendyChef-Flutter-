import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/product/widgets/productsharebutton.dart';
import 'package:trendychef/Presentation/widgets/indicators/circular_progress_with_logo.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/product.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

Widget productImageContainer({
  required ProductModel product,
  required BuildContext context,
}) {
  final lang = AppLocalizations.of(context)!;
  return Stack(
    children: [
      // Background image with zoom functionality
      InteractiveViewer(
        panEnabled: true,
        scaleEnabled: true,
        child: CachedNetworkImage(
          imageUrl: baseHost + product.image,
          fit: BoxFit.cover,
          placeholder: (context, url) => circularPrgIndicatorWithLogo(),
          errorWidget:
              (context, url, error) => Image.asset(
                "assets/images/trendy_logo.png",
                fit: BoxFit.cover,
              ),
          memCacheWidth: 400,
          memCacheHeight: 400,
        ),
      ),

      // Product weight label
      Positioned(
        top: 10,
        right: 10,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.8),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: Text(
            "${product.weight} ${lang.localeName == "en" ? "kg" : "كجم"}",
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),

      // Share button
      Positioned(
        top: 60,
        right: 10,
        child: ProductShareButton(
          title: lang.localeName == "en" ? product.eName : product.arName!,
          imageUrl: baseHost + product.image,
          productUrl: 'https://trendy-c.com/product?id=${product.id}',
          price: product.salePrice,
          weight: product.weight,
        ),
      ),
    ],
  );
}
