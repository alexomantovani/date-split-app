import 'package:date_split_app/core/services/injection_container.dart';
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
          useMaterial3: true,
        ),
        home: const AuthPage(),
      ),
    );
  }
}
