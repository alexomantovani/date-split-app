import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdentificationCard extends StatelessWidget {
  const IdentificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is GetUserSuccess) {
          return Row(
            children: [
              const Icon(Icons.person, size: 80),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.userModel.displayName,
                      style: TextTheme.of(context).titleLarge,
                    ),
                    Text(
                      'ID ${state.userModel.uid}',
                      style: TextTheme.of(context).bodyMedium,
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Sem informações do usuário'),
          );
        }
      },
    );
  }
}
