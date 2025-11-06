// payment_webview_page.dart
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_cancelled.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_faild.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_success.dart';
import 'package:webview_flutter/webview_flutter.dart';


class PaymentWebViewPage extends StatefulWidget {
  final String initialUrl;
  // optional patterns - if not provided, we'll check for common endpoints
  final String? successPattern;   // e.g. '/payment-success'
  final String? cancelledPattern; // e.g. '/payment-cancelled'
  final String? declinedPattern;  // e.g. '/payment-failed'

  const PaymentWebViewPage({
    super.key,
    required this.initialUrl,
    this.successPattern,
    this.cancelledPattern,
    this.declinedPattern,
  });

  @override
  State<PaymentWebViewPage> createState() => _PaymentWebViewPageState();
}

class _PaymentWebViewPageState extends State<PaymentWebViewPage> {
  late final WebViewController _controller;
  bool _isLoading = true;

  String get _successPattern => widget.successPattern ?? '/payment-success';
  String get _cancelledPattern => widget.cancelledPattern ?? '/payment-cancelled';
  String get _declinedPattern => widget.declinedPattern ?? '/payment-failed';

  @override
  void initState() {
    super.initState();

    // Android platform view setup for webview
    if (!kIsWeb && Platform.isAndroid) {
      
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => _isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => _isLoading = false);
          },
          onNavigationRequest: (request) {
            final url = request.url;

           
            if (url.contains(_successPattern)) {
              // Payment authorized
              if (mounted) Navigator.of(context).pop(PaymentSuccessPage());
              return NavigationDecision.prevent;
            }

            if (url.contains(_cancelledPattern)) {
              if (mounted) Navigator.of(context).pop(PaymentCancelledPage());
              return NavigationDecision.prevent;
            }

            if (url.contains(_declinedPattern)) {
              if (mounted) Navigator.of(context).pop(PaymentFailedPage());
              return NavigationDecision.prevent;
            }

            // Otherwise continue navigation
            return NavigationDecision.navigate;
          },
          onWebResourceError: (err) {
            // optional: handle errors and show UI
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // User closed the webview; return unknown/cancelled as you prefer
            Navigator.of(context).pop(PaymentCancelledPage());
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
