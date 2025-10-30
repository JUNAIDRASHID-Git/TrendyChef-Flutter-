import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trendychef/Presentation/home/widget/sections/carousel/cubit/carousel_cubit.dart';
import 'package:trendychef/Presentation/widgets/buttons/paymentBtn/bloc/payment_bloc.dart';
import 'package:trendychef/core/services/routes/go_routes.dart';
import 'package:url_strategy/url_strategy.dart'; // <-- Import this
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/google/bloc/google_bloc.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set URL strategy for Flutter Web (removes the # in URLs)
  setPathUrlStrategy();

  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCgzDBi6Do4qgGBg_O5QHznEEvrqi_tES0",
      authDomain: "trendy-chef-63c6d.firebaseapp.com",
      projectId: "trendy-chef-63c6d",
      storageBucket: "trendy-chef-63c6d.firebasestorage.app",
      messagingSenderId: "524030203276",
      appId: "1:524030203276:web:e70e7d7dd546665460b2a9",
      measurementId: "G-G2YJW5LF4G",
    ),
  );

  final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
  final initialLocale =
      (deviceLocale.languageCode == 'ar')
          ? const Locale('ar')
          : const Locale('en');

  runApp(MyApp(initialLocale: initialLocale));
}

class MyApp extends StatefulWidget {
  final Locale initialLocale;

  const MyApp({super.key, required this.initialLocale});

  static void setLocale(BuildContext context, Locale newLocale) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeLocale(newLocale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _locale;

  @override
  void initState() {
    super.initState();
    _locale = widget.initialLocale;
  }

  void changeLocale(Locale newLocale) {
    setState(() {
      _locale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        
        BlocProvider<BannerSliderCubit>(
          create: (_) => BannerSliderCubit()..loadBanners(), 
        ),
        BlocProvider<SearchBloc>(create: (_) => SearchBloc()),
        BlocProvider(create: (_) => GoogleBloc()),
        BlocProvider(create: (_) => AppleBloc()),
        BlocProvider(create: (_) => PaymentBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'TrendyChef',
        theme: ThemeData(),
        locale: _locale,
        supportedLocales: const [Locale('en'), Locale('ar')],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: appRouter,
      ),
    );
  }
}
