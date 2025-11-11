import 'dart:ui' show PointerDeviceKind;
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/category/category.dart';
import 'package:trendychef/l10n/app_localizations.dart';
import 'package:trendychef/core/services/models/category.dart';
import 'package:trendychef/core/theme/colors.dart';

class CategoryChipButtons extends StatelessWidget {
  const CategoryChipButtons({super.key, required this.categories});

  final List<CategoryModel> categories;

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 12),
            child: Text(
              lang.categories.toUpperCase(),
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w900,
                color: AppColors.fontBlack.withOpacity(0.7),
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),

          // ✅ Wrap in ScrollConfiguration to make horizontal scroll work on web
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isArabic = lang.localeName != "en";

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: InkWell(
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      CategoryProductPage(category: category),
                            ),
                          ),
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: AppColors.fontWhite,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.fontBlack.withOpacity(0.15),
                            width: 1,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        child: Center(
                          child: Text(
                            isArabic
                                ? category.arname
                                : category.ename.toUpperCase(),
                            style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.fontBlack.withOpacity(0.85),
                              letterSpacing: isArabic ? 0 : 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
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
