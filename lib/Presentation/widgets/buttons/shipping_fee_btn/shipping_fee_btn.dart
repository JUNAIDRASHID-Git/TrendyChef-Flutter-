import 'package:flutter/material.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/core/services/models/payment.dart';

class ShippingFeeBtn extends StatefulWidget {
  final PaymentModel payment;
  final VoidCallback onGetShippingFee;

  const ShippingFeeBtn({
    super.key,
    required this.payment,
    required this.onGetShippingFee,
  });

  @override
  State<ShippingFeeBtn> createState() => _ShippingFeeBtnState();
}

class _ShippingFeeBtnState extends State<ShippingFeeBtn>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _errorController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _errorHeightAnimation;
  late Animation<double> _errorOpacityAnimation;

  String? _currentError;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    _errorController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _errorHeightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _errorController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
      ),
    );

    _errorOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _errorController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _errorController.dispose();
    super.dispose();
  }

  String? _validateShippingData() {
    final p = widget.payment;

    if (p.addressLine1.isEmpty) return "Address is required before calculating shipping";
    if (p.city.isEmpty) return "City is required before calculating shipping";
    if (p.region.isEmpty) return "Region is required before calculating shipping";
    if (p.postcode.isEmpty) return "Postal code is required before calculating shipping";
    if (p.phone.isEmpty) return "Phone number is required before calculating shipping";

    return null;
  }

  void _showInlineError(String error) {
    setState(() => _currentError = error);
    _errorController.forward();

    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && _currentError == error) _hideInlineError();
    });
  }

  void _hideInlineError() {
    _errorController.reverse().then((_) {
      if (mounted) setState(() => _currentError = null);
    });
  }

  void _handleShippingFee() {
    final error = _validateShippingData();
    if (error != null) {
      _showInlineError(error);
      return;
    }

    // ✅ Trigger callback to calculate shipping fee
    widget.onGetShippingFee();
  }

  @override
  Widget build(BuildContext context) {
    final hasError = _currentError != null;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _scaleAnimation,
        _errorHeightAnimation,
        _errorOpacityAnimation,
      ]),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Error container
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                height: hasError ? _errorHeightAnimation.value * 50 : 0,
                child: hasError && _currentError != null
                    ? Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53E3E),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE53E3E).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Opacity(
                          opacity: _errorOpacityAnimation.value,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            child: Row(
                              children: [
                                const Icon(Icons.error_outline,
                                    color: Colors.white, size: 18),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    _currentError ?? "",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _hideInlineError,
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Shipping button
              GestureDetector(
                onTapDown: (_) => _scaleController.forward(),
                onTapUp: (_) => _scaleController.reverse(),
                onTapCancel: () => _scaleController.reverse(),
                onTap: _handleShippingFee,
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: _handleShippingFee,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.local_shipping,
                                color: Colors.white, size: 20),
                            SizedBox(width: 12),
                            Text(
                              "Get Shipping Fee",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
