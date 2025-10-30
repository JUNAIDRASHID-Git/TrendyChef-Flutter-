import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:trendychef/Presentation/about/widgets/map_container.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  static const String mapUrl = "https://maps.app.goo.gl/QK8cBvwB4zEK6qfr8";
  static const String phoneNumber = "+966558743707";
  static const String email = "moderncheftrading@gmail.com";
  static const String instagramUrl =
      "https://www.instagram.com/tct_ksa?igsh=MXAyMWMzOGo1a2lqbw==";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.fontWhite,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(CircleBorder()),
                    backgroundColor: WidgetStatePropertyAll(AppColors.primary),
                  ),
                  onPressed: () {
                    context.go("/shop");
                  },
                  icon: Icon(Icons.arrow_back, color: AppColors.fontWhite),
                ),
                Center(child: _buildHeroSection()),
                _buildAboutSection(),
                _buildStatsSection(context),
                _buildShopImageSection(context),
                _buildLocationSection(context),
                _buildPolicySection(context),
                _buildContactSection(context),
                _buildFooterSection(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            height: 500,
            width: 500,
            child: SvgPicture.asset(
              "assets/images/trendy_logo.svg",
              semanticsLabel: "TrendyChef Logo",
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Premium culinary experiences delivered",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Our Story",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          Text(
            "At Trendy Chef, we believe that exceptional cuisine should be accessible to everyone. Since our founding, we've been dedicated to sourcing the finest ingredients and creating memorable culinary experiences that bring people together.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            "Our commitment to quality, sustainability, and innovation drives everything we do. From farm to table, we ensure every product meets our exacting standards.",
            style: TextStyle(
              fontSize: 16,
              height: 1.6,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child:
          MediaQuery.of(context).size.width < 600
              ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildStatCard("10K+", "Happy Customers"),
                  const SizedBox(height: 16),
                  _buildStatCard("1000+", "Premium Products"),
                  const SizedBox(height: 16),
                  _buildStatCard("4.8★", "Average Rating"),
                ],
              )
              : Row(
                children: [
                  Flexible(child: _buildStatCard("10K+", "Happy Customers")),
                  const SizedBox(width: 16),
                  Flexible(child: _buildStatCard("500+", "Premium Products")),
                  const SizedBox(width: 16),
                  Flexible(child: _buildStatCard("4.8★", "Average Rating")),
                ],
              ),
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Visit Our Store",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () => _launchMap(context),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  children: [
                    const Positioned.fill(child: MapContainer()),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dammam, Eastern Province",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(color: Colors.black54, blurRadius: 4),
                              ],
                            ),
                          ),
                          Text(
                            "Tap to open in maps",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              shadows: [
                                Shadow(color: Colors.black54, blurRadius: 4),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.primary.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Get in Touch",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 32),
          MediaQuery.of(context).size.width < 600
              ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildContactCard(
                    Icons.phone_outlined,
                    "Call Us",
                    "+966 558 743 707",
                    () => _launchUrl("tel:$phoneNumber", context),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    Icons.email_outlined,
                    "Email Us",
                    "moderncheftrading@gmail.com",
                    () => _launchUrl("mailto:$email", context),
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    Icons.camera_alt_outlined,
                    "Follow Us",
                    "@tct_ksa",
                    () => _launchUrl(instagramUrl, context),
                  ),
                ],
              )
              : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: _buildContactCard(
                          Icons.phone_outlined,
                          "Call Us",
                          "+966 558 743 707",
                          () => _launchUrl("tel:$phoneNumber", context),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Flexible(
                        child: _buildContactCard(
                          Icons.email_outlined,
                          "Email Us",
                          "moderncheftrading@gmail.com",
                          () => _launchUrl("mailto:$email", context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildContactCard(
                    Icons.camera_alt_outlined,
                    "Follow Us",
                    "@tct_ksa",
                    () => _launchUrl(instagramUrl, context),
                  ),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey[200]!, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShopImageSection(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.secondary,
        ),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            // Left image
            Expanded(
              flex: 2,
              child: Image.asset(
                "assets/images/Storeimg2.webp",
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(width: 4),

            // Right column with two stacked images
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/Storeimg1.webp",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Image.asset(
                      "assets/images/Storeimg1.webp",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(color: Colors.grey[50]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MediaQuery.of(context).size.width < 600
              ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildFeatureItem(
                    Icons.local_shipping_outlined,
                    "Fast Delivery",
                    "Fast and reliable delivery",
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureItem(
                    Icons.verified_user_outlined,
                    "Quality Assured",
                    "Premium ingredients only",
                  ),
                  const SizedBox(height: 24),
                  _buildFeatureItem(
                    Icons.support_agent_outlined,
                    "24/7 Support",
                    "Always here to help",
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: _buildFeatureItem(
                      Icons.local_shipping_outlined,
                      "Fast Delivery",
                      "Fast and reliable delivery",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: _buildFeatureItem(
                      Icons.verified_user_outlined,
                      "Quality Assured",
                      "Premium ingredients only",
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: _buildFeatureItem(
                      Icons.support_agent_outlined,
                      "24/7 Support",
                      "Always here to help",
                    ),
                  ),
                ],
              ),
          const SizedBox(height: 40),
          Divider(color: Colors.grey[300]),
          const SizedBox(height: 20),
          Text(
            "© 2025 Trendy Chef. Made with ❤️ in Saudi Arabia",
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String description) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.primary, size: 32),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> _launchMap(BuildContext context) async {
    try {
      final Uri uri = Uri.parse(mapUrl);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open map application'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening map'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    try {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Could not open link'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening link'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

Widget _buildPolicySection(BuildContext context) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Our Policies",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 24),

        // Privacy Policy
        _buildPolicyCard(
          context,
          "Privacy Policy",
          "We respect your privacy and ensure that your data is protected and used responsibly.",
          () => context.go("/privacy-policy"),
        ),
        const SizedBox(height: 16),

        // Terms & Conditions
        _buildPolicyCard(
          context,
          "Terms & Conditions",
          "Please read our terms to understand your rights and obligations when using our services.",
          () => context.go("/terms&conditions"),
        ),
        const SizedBox(height: 16),

        // Return Policy
        _buildPolicyCard(
          context,
          "Return Policy",
          "We offer an easy and transparent return process for all eligible products.",
          () => context.go("/return-policy"),
        ),
      ],
    ),
  );
}

Widget _buildPolicyCard(
  BuildContext context,
  String title,
  String description,
  VoidCallback onTap,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.policy_outlined, color: AppColors.primary, size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Read More",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
