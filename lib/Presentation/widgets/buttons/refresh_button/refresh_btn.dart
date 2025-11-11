import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class RefreshBtn extends StatelessWidget {
  final Function()? onPressed;
  const RefreshBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.refresh, size: 20, color: AppColors.fontWhite),
      label: Text(lang.refresh, style: TextStyle(color: AppColors.fontWhite)),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
