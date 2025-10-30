import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

Widget searchFieldButton(BuildContext context) {
  final lang = AppLocalizations.of(context)!;

  return InkWell(
    onTap: () => context.go('/search-page'),
    borderRadius: BorderRadius.circular(30),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 58, // Match TextFormField height
      decoration: BoxDecoration(
        color: AppColors.secondary,
        border: Border.all(color: AppColors.primary, width: 1.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 28, color: AppColors.primary),
          const SizedBox(width: 10),
          Text(
            lang.search,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
