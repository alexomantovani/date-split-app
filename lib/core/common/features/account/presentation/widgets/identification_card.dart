import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:date_split_app/core/app/restart_app.dart';
import 'package:date_split_app/core/common/features/account/presentation/bloc/configuration/configuration_bloc.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/services/app_service.dart';
import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/configuration_bottom_sheet.dart';

class IdentificationCard extends StatelessWidget {
  const IdentificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) => state is UpdateUserSuccess
          ? context.blocProvider<AuthBloc>().add(
                const GetUserEvent(),
              )
          : null,
      builder: (context, state) {
        if (state is GetUserSuccess) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.blocProvider<ConfigurationBloc>().add(
                            SelectConfigurationDataEvent(
                              avatar: state.userModel.avatar != null
                                  ? Assets.kAvatarList.firstWhere(
                                      (avatar) => avatar
                                          .contains(state.userModel.avatar!),
                                    )
                                  : null,
                              nickName: state.userModel.nickName,
                            ),
                          );
                      AppService.showAccountConfigurationModal(
                        context: context,
                        child: const ConfigurationBottomSheet(),
                      );
                    },
                    child: SizedBox(
                      height: 82,
                      width: 82,
                      child: Stack(
                        children: [
                          Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  Assets.toAssetPath(
                                      asset: state.userModel.avatar),
                                ),
                                fit: BoxFit.cover,
                              ),
                              shape: BoxShape.circle,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: -1,
                            right: 12,
                            child: SvgPicture.asset(Assets.kIcEdit),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.userModel.nickName != null &&
                                state.userModel.nickName!.isNotEmpty
                            ? state.userModel.nickName!
                            : state.userModel.displayName,
                        style: context.textTheme.titleLarge,
                      ),
                      Text(
                        'ID ${state.userModel.uid.substring((state.userModel.uid.length / 2).toInt())}',
                        style: context.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  LocalPreferences.clearToken();
                  RestartApp.restart(context);
                },
                child: Text(
                  'Sair',
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          );
        } else if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthError) {
          return const Center(
            child: Text('Sem informações do usuário'),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
