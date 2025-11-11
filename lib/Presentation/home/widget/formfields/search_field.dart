import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

Widget searchField({
  required BuildContext context,
  required TextEditingController controller,
  required VoidCallback onClear,
  required ValueChanged<String> onChanged,
}) {
  final lang = AppLocalizations.of(context)!;
  final isArabic = lang.localeName != "en";

  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: controller,
    builder: (context, value, child) {
      return TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        autofocus: true,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.secondary,
          labelText: lang.search,
          labelStyle: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(Icons.search, size: 28, color: AppColors.primary),
          ),
          suffixIcon: Padding(
            padding:
                isArabic
                    ? const EdgeInsets.only(left: 10)
                    : const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.clear, color: AppColors.fontBlack, size: 18),
              onPressed: onClear,
            ),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.primary),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: AppColors.primary, width: 1.5),
          ),
        ),
      );
    },
  );
}
