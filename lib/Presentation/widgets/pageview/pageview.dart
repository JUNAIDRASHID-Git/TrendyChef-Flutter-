import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:trendychef/Presentation/home/widget/formfields/fake_search_btn.dart';
import 'package:trendychef/Presentation/home/widget/vedio_cont/vedio_container.dart';
import 'package:trendychef/Presentation/widgets/containers/language_selector.dart';
import 'package:trendychef/core/theme/colors.dart';
import 'package:trendychef/l10n/app_localizations.dart';

class BottomNavScreen extends StatefulWidget {
  final Widget child;
  const BottomNavScreen({super.key, required this.child});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/shop')) return 0;
    if (location.startsWith('/cart')) return 1;
    if (location.startsWith('/profile')) return 2;
    return 0;
  }

  void _onNavBarTap(int index) {
    switch (index) {
      case 0:
        context.go('/shop');
        break;
      case 1:
        context.go('/cart');
        break;
      case 2:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final lang = AppLocalizations.of(context)!;
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,

      extendBody: true,
      body: NestedScrollView(
        headerSliverBuilder:
            (context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: AppColors.fontWhite,
                pinned: false,
                toolbarHeight: selectedIndex == 0 ? 120 : 60,
                elevation: 0,
                automaticallyImplyLeading: false,
                flexibleSpace: SafeArea(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (lang.localeName == "en")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    "Trendy Chef",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "logofont",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),

                              if (lang.localeName == "ar")
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: Text(
                                    "الشيف العصري",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),

                              // Right side (nav buttons, language, etc.)
                              Row(
                                children: [
                                  if (screenWidth > 750) ...[
                                    _navButton(
                                      lang.shop,
                                      0,
                                      selectedIndex,
                                      Iconsax.shop,
                                      _onNavBarTap,
                                    ),
                                    _navButton(
                                      lang.cart,
                                      1,
                                      selectedIndex,
                                      Iconsax.shopping_cart,
                                      _onNavBarTap,
                                    ),
                                    _navButton(
                                      lang.profile,
                                      2,
                                      selectedIndex,
                                      Iconsax.user,
                                      _onNavBarTap,
                                    ),
                                  ],
                                  if (selectedIndex == 0) ...[
                                    const LanguageSelector(),
                                    const SizedBox(width: 10),
                                  ],
                                  if (screenWidth < 750 &&
                                      (selectedIndex == 1 ||
                                          selectedIndex == 2)) ...[
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        Icon(
                                          selectedIndex == 1
                                              ? Iconsax.shopping_cart
                                              : Iconsax.user,
                                          color: AppColors.primary,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          selectedIndex == 1
                                              ? lang.cart
                                              : lang.profile,
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins",
                                            color: AppColors.primary,
                                            letterSpacing:
                                                lang.localeName == "en"
                                                    ? 0.5
                                                    : 0,
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          if (selectedIndex == 0)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 50,
                                      child: searchFieldButton(context),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  LoopingVideoWidget(
                                    videoPath:
                                        "https://res.cloudinary.com/dl6hhtug2/video/upload/v1753890815/promo_vedio_t8znza.mp4",
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Colors.grey.shade200],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),

      // Bottom Navigation (mobile only)
      bottomNavigationBar:
          screenWidth < 750
              ? Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Container(
                      height: 70,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 9),
                        child: GNav(
                          selectedIndex: selectedIndex,
                          onTabChange: _onNavBarTap,
                          color: AppColors.fontWhite,
                          activeColor: AppColors.fontBlack,
                          tabBackgroundColor: AppColors.secondary,
                          tabBorderRadius: 30,
                          padding: const EdgeInsets.all(16),
                          gap: 5,
                          tabs: [
                            GButton(icon: Iconsax.shop, text: lang.shop),
                            GButton(
                              icon: Iconsax.shopping_cart,
                              text: lang.cart,
                            ),
                            GButton(icon: Iconsax.user, text: lang.profile),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
              : null,
    );
  }

  Widget _navButton(
    String label,
    int index,
    int selectedIndex,
    IconData icon,
    void Function(int) onTap,
  ) {
    final bool isSelected = selectedIndex == index;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow:
            isSelected
                ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ]
                : [],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onTap(index),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: isSelected ? AppColors.fontWhite : AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.fontWhite : AppColors.primary,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
