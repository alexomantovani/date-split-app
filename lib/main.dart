import 'package:date_split_app/core/services/injection_container.dart';
import 'package:date_split_app/core/utils/constants.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/presentation/views/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<AuthBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryBlue),
          useMaterial3: true,
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              color: kPrimaryText,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: kFontFamily,
            ),
            bodyMedium: TextStyle(
              color: kDescriptionText,
              fontFamily: kFontFamily,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const AuthPage(),
      ),
    );
  }
}
