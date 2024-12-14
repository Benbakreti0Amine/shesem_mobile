import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cache/cachehelper.dart';
import 'core/api/dio_consumer.dart';
import 'representation/cubit/user_cubit.dart';
import 'representation/cubit/user_signupcubit.dart';
import 'representation/screens/profile_screen.dart';
import 'representation/screens/sign_in_screen.dart';


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
//
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
