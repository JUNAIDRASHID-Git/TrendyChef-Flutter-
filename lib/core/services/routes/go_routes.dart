import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trendychef/Presentation/about/about.dart';
import 'package:trendychef/Presentation/auth/pages/auth.dart';
import 'package:trendychef/Presentation/cart/cart.dart';
import 'package:trendychef/Presentation/checkout/check_out.dart';
import 'package:trendychef/Presentation/home/home.dart';
import 'package:trendychef/Presentation/intro/page/intro.dart';
import 'package:trendychef/Presentation/product/pages/product.dart';
import 'package:trendychef/Presentation/product/pages/product_error.dart';
import 'package:trendychef/Presentation/profile/profile.dart';
import 'package:trendychef/Presentation/search/search.dart';
import 'package:trendychef/Presentation/widgets/order_status_pages/order_success.dart';
import 'package:trendychef/Presentation/widgets/pageview/pageview.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_cancelled.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_faild.dart';
import 'package:trendychef/Presentation/widgets/paymentstatus/payment_success.dart';
import 'package:trendychef/core/policy/privacy_policy.dart';
import 'package:trendychef/core/policy/return_policy.dart';
import 'package:trendychef/core/policy/terms_and_conditions.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/', // splash screen is the entry point
  debugLogDiagnostics: true,

  // Only redirect if required, but skip during splash
  redirect: (BuildContext context, GoRouterState state) async {
    // Publicly accessible routes
    final allowedPublicRoutes = {
      '/',
      '/auth',
      '/privacy-policy',
      '/terms&conditions',
      '/return-policy',
    };

    if (allowedPublicRoutes.contains(state.uri.path)) {
      return null;
    }

    // Auth check for private routes
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null || token.isEmpty) {
      return '/auth';
    }

    return null;
  },

  routes: [
    GoRoute(path: '/', builder: (context, state) => const IntroPage()),

    GoRoute(path: '/auth', builder: (context, state) => const AuthPage()),

    GoRoute(path: '/home', builder: (context, state) => const AboutPage()),
    GoRoute(
      path: '/checkout',
      builder: (context, state) => const CheckOutPage(),
    ),

    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => const PrivacyPolicyPage(),
    ),
    GoRoute(
      path: '/return-policy',
      builder: (context, state) => const ReturnPolicyPage(),
    ),
    GoRoute(
      path: '/terms&conditions',
      builder: (context, state) => const TermsAndConditionsPage(),
    ),

    GoRoute(
      path: '/order-success',
      builder: (context, state) => const OrderSuccessPage(),
    ),

    GoRoute(
      path: '/payment-success',
      builder: (context, state) => const PaymentSuccessPage(),
    ),

    GoRoute(
      path: '/payment-failed',
      builder: (context, state) => const PaymentFailedPage(),
    ),

    GoRoute(
      path: '/payment-cancelled',
      builder: (context, state) => const PaymentCancelledPage(),
    ),

    GoRoute(path: '/search-page', builder: (context, state) => SearchPage()),

    GoRoute(
      path: '/product',
      builder: (context, state) {
        final id = state.uri.queryParameters['id'];
        if (id != null && id.isNotEmpty) {
          return Productpage(productID: id);
        } else {
          return const ProductErrorPage();
        }
      },
    ),

    ShellRoute(
      builder: (context, state, child) => BottomNavScreen(child: child),
      routes: [
        GoRoute(path: '/shop', builder: (context, state) => const HomePage()),
        GoRoute(path: '/cart', builder: (context, state) => const CartPage()),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
    ),
  ],
);
