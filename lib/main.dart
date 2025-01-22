import 'package:date_split_app/core/app/restart_app.dart';
import 'package:date_split_app/core/common/features/account/presentation/bloc/configuration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/services/app_service.dart';
import 'package:date_split_app/core/services/injection_container.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

void main() async {
  await init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RestartApp(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<ConfigurationBloc>(
          create: (context) => sl<ConfigurationBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Styles.kPrimaryBlue),
          useMaterial3: true,
          textTheme: TextTheme(
            titleLarge: Styles.titleLarge,
            titleMedium: Styles.titleMedium,
            bodyMedium: Styles.bodyMedium,
          ),
        ),
        home: AppService.homeBuilder(),
      ),
    );
  }
}
