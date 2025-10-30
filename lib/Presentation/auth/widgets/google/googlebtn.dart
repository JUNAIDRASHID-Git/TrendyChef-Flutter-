import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/google/bloc/google_bloc.dart';
import 'package:trendychef/core/theme/colors.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GoogleBloc, GoogleState>(
      builder: (context, state) {
        final bool isLoading = state is GoogleLoading;

        return AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            // Animate the gradient shifting
            final gradient = SweepGradient(
              startAngle: 0,
              endAngle: 6.28319, // 2 * pi
              colors: const [
                Color(0xFF4285F4), // Google Blue
                Color(0xFF34A853), // Google Green
                Color(0xFFFBBC05), // Google Yellow
                Color(0xFFEA4335), // Google Red
                Color(0xFF4285F4), // back to Blue for smooth loop
              ],
              stops: const [0.0, 0.25, 0.5, 0.75, 1.0],
              transform: GradientRotation(_controller.value * 6.28319),
            );

            return Container(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(18),
                gradient: gradient,
              ),
              padding: const EdgeInsets.all(2.5), // Border thickness
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                elevation: isLoading ? 2 : 6,
                shadowColor: Colors.blue.withOpacity(0.3),
                child: InkWell(
                  onTap:
                      isLoading
                          ? null
                          : () {
                            context.read<GoogleBloc>().add(
                              GoogleSignInEvent(context: context),
                            );
                          },
                  borderRadius: BorderRadius.circular(16),
                  splashColor: Colors.blue.withOpacity(0.1),
                  highlightColor: Colors.blue.withOpacity(0.05),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          AppColors.fontWhite,
                          AppColors.fontWhite.withOpacity(0.95),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child:
                          isLoading
                              ? SizedBox(
                                width: 28,
                                height: 28,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue.shade600,
                                  ),
                                ),
                              )
                              : Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(14),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      "assets/images/google_logo.png",
                                      height: 40,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  const Text(
                                    "Continue with Google",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.3,
                                      color: Color(0xFF1F1F1F),
                                    ),
                                  ),
                                ],
                              ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
