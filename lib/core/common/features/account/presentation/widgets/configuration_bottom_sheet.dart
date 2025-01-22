import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/common/features/account/presentation/bloc/configuration_bloc.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

class ConfigurationBottomSheet extends StatefulWidget {
  const ConfigurationBottomSheet({super.key});

  @override
  State<ConfigurationBottomSheet> createState() =>
      _ConfigurationBottomSheetState();
}

class _ConfigurationBottomSheetState extends State<ConfigurationBottomSheet> {
  late TextTheme theme;
  final TextEditingController nickNameController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = context.textTheme;
  }

  @override
  void dispose() {
    super.dispose();
    nickNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        if (state is SelectConfigurationDataSuccess) {
          nickNameController.text = state.nickName ?? '';
          return BottomSheet(
            onClosing: () {},
            builder: (context) => Container(
              height: context.height,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Voltar',
                          style: theme.titleMedium,
                        ),
                      ),
                      Text(
                        'Configurações',
                        style: theme.titleLarge,
                      ),
                      TextButton(
                        onPressed: () {
                          String? avatar = state.avatar
                              ?.replaceAll('lib/assets/avatar/', '')
                              .replaceAll('.png', '');
                          context.blocProvider<AuthBloc>().add(
                                UpdateUserEvent(
                                  token: null,
                                  avatar: avatar,
                                  nickName: nickNameController.text,
                                ),
                              );
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Confirmar',
                          style: theme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text('Apelido', style: theme.titleLarge),
                  CustomField(
                    controller: nickNameController,
                    defaultBorder: false,
                    enabledBorderColor: Styles.kStandardLightGrey,
                    mainStyle: theme.bodyMedium,
                  ),
                  const SizedBox(height: 20.0),
                  Text('Avatar', style: theme.titleLarge),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (Assets.kAvatarList.length / 3).toInt(),
                      ),
                      itemCount: Assets.kAvatarList.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () =>
                            context.blocProvider<ConfigurationBloc>().add(
                                  SelectConfigurationDataEvent(
                                    avatar: Assets.kAvatarList[index],
                                    nickName: nickNameController.text,
                                  ),
                                ),
                        child: Container(
                          height: 32,
                          width: 32,
                          margin: const EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                            border: state.avatar != null &&
                                    state.avatar == Assets.kAvatarList[index]
                                ? Border.all(
                                    color: Styles.kStandardBlack,
                                    width: 2.0,
                                  )
                                : null,
                            image: DecorationImage(
                              image: AssetImage(Assets.kAvatarList[index]),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
