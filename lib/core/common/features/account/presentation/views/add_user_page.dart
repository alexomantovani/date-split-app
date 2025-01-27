import 'package:date_split_app/core/common/features/account/presentation/widgets/follow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/common/features/account/presentation/bloc/account/account_bloc.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/extensions/string_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController friendContoller = TextEditingController();
  List<bool> followingNickNameList = [];

  @override
  void dispose() {
    friendContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Voltar',
                  style: context.textTheme.titleMedium,
                ),
              ),
              Text(
                'Adicionar Amigo',
                style: context.textTheme.titleLarge,
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Confimar',
                  style: context.textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const Divider(),
          const SizedBox(height: 20.0),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomField(
                controller: friendContoller,
                filled: true,
                fillColour: Styles.kBgField,
                enabledBorderColor: Styles.kDescriptionText,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Precure Amigos',
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    context.blocProvider<AccountBloc>().add(
                          GetPartyUsersEvent(
                            uid: null,
                            nickName: value.firstToUpper,
                            displayName: null,
                          ),
                        );
                  } else {
                    context
                        .blocProvider<AccountBloc>()
                        .add(const ClearPartyUserEvent());
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state is GetPartyUsersSuccess) {
                if (state.partyUserList != null &&
                    state.partyUserList!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.partyUserList!.length,
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
                                        asset:
                                            state.partyUserList![index].avatar),
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                right: 16.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.partyUserList![index].nickName !=
                                                null &&
                                            state.partyUserList![index]
                                                .nickName!.isNotEmpty
                                        ? state.partyUserList![index].nickName!
                                        : '',
                                    style: context.textTheme.titleLarge,
                                  ),
                                  FollowButton(
                                    uid: state.partyUserList![index].uid,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else if (state is AccountError || state is AccountInitial) {
                return const SizedBox();
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
