import 'package:flutter/material.dart';
import 'package:trendychef/core/services/api/auth/logout.dart';
import 'package:trendychef/l10n/app_localizations.dart';

ElevatedButton logOutBtn(BuildContext context) {
  final lang = AppLocalizations.of(context)!;
  return ElevatedButton(
    onPressed: () {
      logout(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    ),
    child: Text(lang.logout, style: TextStyle(color: Colors.white)),
  );
}
