import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:date_split_app/core/common/features/account/presentation/views/add_user_page.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/core_utils.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

class PartyUserTabView extends StatefulWidget {
  const PartyUserTabView({super.key});

  @override
  State<PartyUserTabView> createState() => _PartyUserTabViewState();
}

class _PartyUserTabViewState extends State<PartyUserTabView> {
  final GlobalKey<FormState> _formKeyFollowing = GlobalKey<FormState>();
  final TextEditingController friendContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Form(
                  key: _formKeyFollowing,
                  child: CustomField(
                    controller: friendContoller,
                    filled: true,
                    fillColour: Styles.kBgField,
                    enabledBorderColor: Styles.kDescriptionText,
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Precure Amigos',
                    onChanged: (value) {},
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              GestureDetector(
                onTap: () => CoreUtils.unNamedRouteNavigation(
                  context: context,
                  customRoute: true,
                  page: const AddUserPage(),
                ),
                child: SvgPicture.asset(Assets.kIcAddUser),
              ),
              const SizedBox(width: 10.0),
              SvgPicture.asset(Assets.kIcFilterList),
            ],
          ),
          const SizedBox(height: 20.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is GetUserSuccess) {
                if (state.userModel.following != null &&
                    state.userModel.following!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.userModel.following!.length,
                      itemBuilder: (context, index) => Row(
                        children: [
                          SizedBox(
                            height: 82,
                            width: 82,
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    Assets.toAssetPath(
                                        asset: state.userModel.following![index]
                                            .avatar),
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
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.userModel.following![index].nickName ??
                                    '',
                                style: context.textTheme.titleLarge,
                              ),
                              Text(
                                'ID ${state.userModel.following![index].uid.substring((state.userModel.following![index].uid.length / 2).toInt())}',
                                style: context.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      Image.asset(Assets.kMeditating),
                      Text(
                        'Sem amigos por aqui',
                        style: context.textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'Convide amigos para desbloquear funcionalidades',
                        style: context.textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }
              } else if (state is AuthError || state is AuthInitial) {
                return Column(
                  children: [
                    Image.asset(Assets.kMeditating),
                    Text(
                      'Sem amigos por aqui',
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Convide amigos para desbloquear funcionalidades',
                      style: context.textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
