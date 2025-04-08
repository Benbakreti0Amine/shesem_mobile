import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/cubit/user_report_cubit.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/onboarding.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/sign_in_screen.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/sign_up_screen.dart';
import 'package:happy_tech_mastering_api_with_flutter/representation/screens/splashScreen.dart';
import 'cache/cachehelper.dart';
import 'core/api/dio_consumer.dart';
import 'representation/cubit/user_cubit.dart';
import 'representation/cubit/user_signupcubit.dart';
import 'representation/screens/rootpage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  CacheHelper().init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SignInCubit(DioConsumer(dio: Dio())),
        ),
        BlocProvider(
          create: (context) => SignUpCubit(DioConsumer(dio: Dio())),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins', // Using your configured font family name
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      home: RootPage(),
      // SplashScreen(),
      locale: const Locale('ar'), // Set locale to Arabic
      localizationsDelegates: const [
        // Add required localization delegates
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic
      ],
    );
  }
}
