import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

Widget searchFieldButton(BuildContext context) {
  final lang = AppLocalizations.of(context)!;

  return InkWell(
    onTap: () => context.go('/search-page'),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.fontWhite,
        border: Border.all(
          color: AppColors.fontBlack.withOpacity(0.2),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 28,
            color: AppColors.fontBlack.withOpacity(0.8),
          ),
          const SizedBox(width: 10),
          Text(
            lang.search,
            style: TextStyle(
              color: AppColors.fontBlack.withOpacity(0.8),
              fontSize: 20,
            ),
          ),
        ],
      ),
    ),
  );
}
