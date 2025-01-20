import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/services/app_service.dart';
import 'package:date_split_app/core/services/injection_container.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/features/auth/presentation/views/auth_page.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();
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
          colorScheme: ColorScheme.fromSeed(seedColor: Styles.kPrimaryBlue),
          useMaterial3: true,
          textTheme: TextTheme(
            titleLarge: Styles.bodyLarge,
            bodyMedium: Styles.bodyMedium,
          ),
        ),
        home: FutureBuilder<Widget>(
          future: AppService.getInitialPage(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Material(
                child: Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else if (snapshot.hasData) {
              return snapshot.data!;
            } else {
              return const AuthPage();
            }
          },
        ),
      ),
    );
  }
}
