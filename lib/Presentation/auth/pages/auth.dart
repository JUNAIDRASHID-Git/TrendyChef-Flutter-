// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/auth/widgets/google/googlebtn.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  // Define the brand colors based on the logo

  @override
  Widget build(BuildContext context) {
    // Get screen size to implement responsive design
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      body: SafeArea(child: _buildMobileLayout(context, screenSize)),
    );
  }

  // Single column layout for mobile devices
  Widget _buildMobileLayout(BuildContext context, Size screenSize) {
    final bool isSmallMobile = screenSize.width < 360;
    final lang = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.1,
          ),
        ),
        constraints: BoxConstraints(
          minHeight: screenSize.height - MediaQuery.of(context).padding.top,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo section
                  SizedBox(
                    width: isSmallMobile ? 220 : 300,
                    height: isSmallMobile ? 220 : 300,
                    child: SvgPicture.asset(
                      "assets/images/trendy_logo.svg",
                      fit: BoxFit.contain,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // Middle section with auth buttons
                  Column(
                    children: [
                      GoogleSignInButton(),
                      const SizedBox(height: 20),

                      // AppleSignInButton(), // Uncomment if needed
                      const SizedBox(height: 15),
                      Column(
                        children: [
                          Text(
                            lang.bysigninginyouagreetoour,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 95, 95, 95),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () {
                                  context.go("/privacy-policy");
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Privacy Policy",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text("& "),
                              const SizedBox(width: 4),
                              TextButton(
                                onPressed: () {
                                  context.go("/terms&conditions");
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.primary,
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: const Text(
                                  "Terms & Conditions",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
