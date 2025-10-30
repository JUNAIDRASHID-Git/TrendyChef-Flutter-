// lib/widgets/platform_webview_web.dart
import 'package:flutter/material.dart';

class PlatformWebView extends StatelessWidget {
  final String initialUrl;
  final dynamic navigationDelegate;

  const PlatformWebView({
    super.key,
    required this.initialUrl,
    this.navigationDelegate,
  });

  @override
  Widget build(BuildContext context) {
    // On web we don't render a native WebView. This placeholder prevents analyzer errors.
    return Center(
      child: Text(
        'Preview unavailable — open in browser',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[700]),
      ),
    );
  }
}
