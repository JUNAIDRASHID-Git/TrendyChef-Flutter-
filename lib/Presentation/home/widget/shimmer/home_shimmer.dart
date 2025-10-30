import 'package:flutter/material.dart';

class HomeSkeletonLoader extends StatelessWidget {
  const HomeSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gradient-based carousel shimmer
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildGradientShimmer(
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    colors: [
                      Colors.grey.shade300,
                      Colors.grey.shade200,
                      Colors.grey.shade100,
                      Colors.grey.shade200,
                      Colors.grey.shade300,
                    ],
                    stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          ...List.generate(
            3,
            (index) => _buildPremiumCategoryPlaceholder(context),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCategoryPlaceholder(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category title
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: _buildGradientShimmer(
            child: Container(
              height: 20,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade300,
                    Colors.grey.shade100,
                    Colors.grey.shade300,
                  ],
                ),
              ),
            ),
          ),
        ),

        // Product cards
        SizedBox(
          height: 320,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return _buildPremiumProductCard(index);
            },
          ),
        ),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPremiumProductCard(int index) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          // Image with pulse animation
          _buildPulseShimmer(
            delay: Duration(milliseconds: index * 200),
            child: Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Text elements with wave animation
          _buildWaveShimmer(
            delay: Duration(milliseconds: 300 + index * 100),
            child: Container(
              height: 16,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(height: 8),

          _buildWaveShimmer(
            delay: Duration(milliseconds: 400 + index * 100),
            child: Container(
              height: 14,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),

          const Spacer(),

          _buildWaveShimmer(
            delay: Duration(milliseconds: 500 + index * 100),
            child: Container(
              height: 32,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientShimmer({required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 1500),
      builder: (context, value, child) {
        return AnimatedBuilder(
          animation: AlwaysStoppedAnimation(value),
          builder: (context, child) {
            return child!;
          },
          child: child,
        );
      },
      child: child,
    );
  }

  Widget _buildPulseShimmer({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.7, end: 1.0),
      duration: const Duration(milliseconds: 1000),
      builder: (context, value, child) {
        return AnimatedOpacity(
          opacity: value,
          duration: const Duration(milliseconds: 300),
          child: child,
        );
      },
      child: child,
    );
  }

  Widget _buildWaveShimmer({
    required Widget child,
    Duration delay = Duration.zero,
  }) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 800 + delay.inMilliseconds),
      curve: Curves.easeInOut,
      child: child,
    );
  }
}
