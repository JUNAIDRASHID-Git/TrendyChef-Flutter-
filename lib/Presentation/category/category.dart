import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/widgets/cards/product_card.dart';
import 'package:trendychef/core/services/models/category.dart';
import 'package:trendychef/core/theme/colors.dart';

class CategoryProductPage extends StatelessWidget {
  final CategoryModel category;

  const CategoryProductPage({super.key, required this.category});

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

      // appBar: AppBar(
      //   backgroundColor: AppColors.fontWhite,
      //   leading:
      body: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back, color: AppColors.primary),
              ),
              Hero(
                tag: "category_products_${category.iD}",
                child: Text(
                  category.ename,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 22,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(1.0),
                    itemCount: category.products!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio:
                          0.55, // Adjusted instead of fixed extent
                    ),
                    itemBuilder: (context, index) {
                      final products = category.products!;
                      return ProductCard(product: products[index]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
