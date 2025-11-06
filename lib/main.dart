import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trendychef/Presentation/home/widget/sections/carousel/cubit/carousel_cubit.dart';
import 'package:trendychef/Presentation/widgets/buttons/paymentBtn/bloc/payment_bloc.dart';
import 'package:trendychef/core/services/routes/go_routes.dart';
import 'package:trendychef/Presentation/auth/widgets/apple/bloc/apple_bloc.dart';
import 'package:trendychef/Presentation/auth/widgets/google/bloc/google_bloc.dart';
import 'package:trendychef/Presentation/search/bloc/search_bloc.dart';
import 'package:trendychef/core/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyCkCcI9xWyxcdyfuQHyorkrDvi9IB8_Xn4",
      authDomain: "trendy-c-57ade.firebaseapp.com",
      projectId: "trendy-c-57ade",
      storageBucket: "trendy-c-57ade.firebasestorage.app",
      messagingSenderId: "156938940217",
      appId: "1:156938940217:web:73301befe1a655b1c082e8",
      measurementId: "G-MQLLMN0F5P"
      ),
    );
  } on FirebaseException catch (e) {
    if (e.code == 'duplicate-app') {
      // Firebase is already initialized, safe to continue
      Firebase.app();
    } else {
      // Other Firebase initialization error
      rethrow;
    }
  }

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
