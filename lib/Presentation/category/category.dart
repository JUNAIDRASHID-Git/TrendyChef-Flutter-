import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/widgets/cards/product_card.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/models/product.dart';

class CategoryProductPage extends StatelessWidget {
  final String categoryTitle;
  final int categoryid;
  final List<ProductModel> products;

  const CategoryProductPage({
    super.key,
    required this.categoryTitle,
    required this.products,
    required this.categoryid,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Responsive columns
    int crossAxisCount =
        screenWidth > 1000
            ? 5
            : screenWidth > 800
            ? 4
            : screenWidth > 600
            ? 3
            : 2;

    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      appBar: AppBar(
        backgroundColor: AppColors.fontWhite,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: AppColors.primary),
        ),
        title: Hero(
          tag: "category_products_$categoryid",
          child: Text(
            categoryTitle,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 28,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  padding: const EdgeInsets.all(1.0),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 0.55, // Adjusted instead of fixed extent
                  ),
                  itemBuilder: (context, index) {
                    return ProductCard(product: products[index]);
                  },
                );
              },
            ),
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
