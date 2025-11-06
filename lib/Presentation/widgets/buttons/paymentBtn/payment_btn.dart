// payment_btn.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/widgets/buttons/paymentBtn/bloc/payment_bloc.dart';
import 'package:trendychef/Presentation/widgets/buttons/paymentBtn/payment_web_view.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/models/payment.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';
import 'package:universal_html/html.dart' as html; // used only on web, but safe to import
import 'package:url_launcher/url_launcher.dart';

class PaymentBtn extends StatefulWidget {
  final PaymentModel payment;
  final double shippingCost;

  const PaymentBtn({
    super.key,
    required this.payment,
    required this.shippingCost,
  });

  @override
  State<PaymentBtn> createState() => _PaymentBtnState();
}

class _PaymentBtnState extends State<PaymentBtn> {
  html.WindowBase? _popup;

  String? _validatePaymentData() {
    if (widget.payment.addressLine1.isEmpty) return "Address is required";
    if (widget.payment.city.isEmpty) return "City is required";
    if (widget.payment.region.isEmpty) return "Region is required";
    if (widget.payment.postcode.isEmpty) return "Postal code is required";
    if (widget.payment.phone.isEmpty) return "Phone number is required";
    return null;
  }

  void _handlePayment(BuildContext context) {
    final error = _validatePaymentData();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: Colors.red),
      );
      return;
    }

    // Trigger BLoC to get payment URL (your existing flow)
    context.read<PaymentBloc>().add(InitPayment(payment: widget.payment));
  }

  Future<void> _openUrlCrossPlatform(String url) async {
    // Web: open a popup / new tab
    if (kIsWeb) {
      try {
        if (_popup == null || _popup!.closed!) {
          _popup = html.window.open(url, '_blank');
        } else {
          // reuse the popup if already opened
          _popup!.location.href = url;
        }
      } catch (e) {
        // If popup blocked or error, attempt to open in same tab
        html.window.location.href = url;
      }
      return;
    }

    // Mobile (Android/iOS): try external browser first
    final uri = Uri.parse(url);
    try {
      final launched = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        // fallback to in-app webview if external browser couldn't be launched
        if (!mounted) return;
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => PaymentWebViewPage(initialUrl: url)),
        );
      }
    } catch (e) {
      // On any error, fallback to in-app webview
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PaymentWebViewPage(initialUrl: url)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    return BlocListener<PaymentBloc, PaymentState>(
      listener: (context, state) async {
        if (state is PaymentLoaded) {
          final url = state.url;
          await _openUrlCrossPlatform(url);
        } else if (state is PaymentError) {
          if (_popup != null) {
            _popup!.close();
            _popup = null;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: BlocBuilder<PaymentBloc, PaymentState>(
        builder: (context, state) {
          final isLoading = state is PaymentLoading;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: isLoading ? null : () => _handlePayment(context),
              borderRadius: BorderRadius.circular(24),
              splashColor: Colors.white.withOpacity(0.15),
              highlightColor: Colors.white.withOpacity(0.08),
              child: Ink(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned.fill(child: CustomPaint(painter: CardPatternPainter())),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                          gradient: LinearGradient(
                            colors: [Colors.white.withOpacity(0.2), Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: isLoading ? _buildLoadingState() : _buildCardContent(lang),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Processing Payment...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardContent(AppLocalizations lang) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  colors: [Colors.amber.shade400, Colors.amber.shade700],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: const Icon(
                Icons.credit_card_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            Icon(
              Icons.contactless_rounded,
              color: Colors.white.withOpacity(0.8),
              size: 32,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: List.generate(
            4,
            (_) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                children: List.generate(
                  4,
                  (_) => Container(
                    width: 6,
                    height: 6,
                    margin: const EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lang.pay.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontWeight: FontWeight.w600,
                    fontSize: 11,
                    letterSpacing: lang.localeName == "en" ? 2 : 0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.payment.amount.toStringAsFixed(2)} SAR",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    letterSpacing: 1,
                    shadows: [
                      Shadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.primary,
                size: 28,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.05)..style = PaintingStyle.fill;
    const spacing = 60.0;
    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      for (double y = -spacing; y < size.height + spacing; y += spacing) {
        canvas.drawCircle(Offset(x, y), 40, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
