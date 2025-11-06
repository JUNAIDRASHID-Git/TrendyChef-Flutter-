import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/home/widget/btn/cart_btn.dart';
import 'package:trendychef/Presentation/home/widget/btn/out_of_stock.dart';
import 'package:trendychef/Presentation/home/widget/product_detail_dialog/product_detail_dialog.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/constants/const.dart';
import 'package:trendychef/core/services/models/product.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    final offerPercentage = _calculateOfferPercentage(product);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
      child: Stack(
        children: [
          _CardBody(
            key: ValueKey('product_card_${product.id}'),
            product: product,
            localeName: lang.localeName,
            onTap: () => _openProductDialog(context, product.id.toString()),
          ),
          if (offerPercentage >= 30)
            OfferBadge(percentage: '$offerPercentage%', top: 8, right: 8),
          if (product.stock > 0 && product.stock <= 5)
            _buildBadge(
              text: "Low Stock",
              icon: Icons.warning_rounded,
              bgColor: Colors.orange,
              top: 8,
              left: 8,
            ),
        ],
      ),
    );
  }

  static int _calculateOfferPercentage(ProductModel p) {
    if (p.regularPrice > 0 && p.salePrice < p.regularPrice) {
      return (((p.regularPrice - p.salePrice) / p.regularPrice) * 100).round();
    }
    return 0;
  }

  void _openProductDialog(BuildContext context, String productId) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierColor: Colors.black54,
        pageBuilder:
            (_, _, _) => Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth:
                      kIsWeb
                          ? 500 // constrain for web screens
                          : MediaQuery.of(context).size.width * 0.9,
                  maxHeight: MediaQuery.of(context).size.height * 0.8,
                ),
                child: ProductDialogPage(productID: productId),
              ),
            ),
        transitionsBuilder: (_, animation, _, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          );
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(scale: curved, child: child),
          );
        },
      ),
    );
  }

  Widget _buildBadge({
    required String text,
    Color bgColor = const Color.fromARGB(255, 255, 17, 0),
    IconData? icon,
    double? top,
    double? left,
    double? right,
  }) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, color: Colors.white, size: 12),
              const SizedBox(width: 3),
            ],
            Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}

class _CardBody extends StatelessWidget {
  final ProductModel product;
  final String localeName;
  final VoidCallback onTap;

  const _CardBody({
    super.key,
    required this.product,
    required this.localeName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
              image: const DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
                opacity: 0.06,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Hero(
                  tag: "product_${product.id}",
                  child: Center(
                    child: SizedBox(
                      width: 140,
                      height: 140,
                      child: _ProductImage(imagePath: product.image),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      localeName == "en"
                          ? product.eName.toUpperCase()
                          : (product.arName ?? ''),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Poppins",
                        height: 1.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                _PriceWeightRow(product: product, localeName: localeName),
                const SizedBox(height: 10),
                Center(
                  child:
                      product.stock == 0
                          ? outOfStockBtn()
                          : CartButton(
                            productId: "${product.id}",
                            productPrice: product.salePrice,
                          ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imagePath;

  const _ProductImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return Image.asset("assets/images/trendy_logo.png", fit: BoxFit.cover);
    }

    final imageWidget = Image.network(
      baseHost + imagePath,
      fit: BoxFit.cover,
      width: 150,
      height: 150,
      cacheWidth: 300,
      cacheHeight: 300,
      filterQuality: FilterQuality.low,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Center(child: CircularProgressIndicator(strokeWidth: 2));
      },
      errorBuilder: (_, _, _) => const Icon(Icons.broken_image, size: 40),
    );

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: imageWidget,
      ),
    );
  }
}

class _PriceWeightRow extends StatelessWidget {
  final ProductModel product;
  final String localeName;

  const _PriceWeightRow({required this.product, required this.localeName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${product.regularPrice}",
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: 14,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Image.asset(
                          "assets/images/riyal_logo.png",
                          width: 12,
                          color: Colors.grey.shade600,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        "${product.weight} ${localeName == "en" ? "kg" : "كجم"}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OfferBadge extends StatelessWidget {
  final String percentage;
  final double? top, left, right, bottom;

  const OfferBadge({
    super.key,
    required this.percentage,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.9),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              percentage,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'OFF',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
