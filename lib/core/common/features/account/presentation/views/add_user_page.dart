import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:date_split_app/core/common/features/account/presentation/bloc/account/account_bloc.dart';
import 'package:date_split_app/core/common/features/account/presentation/bloc/manage/manage_data_bloc.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/party_user_list_view.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/extensions/string_extension.dart';
import 'package:date_split_app/core/services/local_preferences.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController friendContoller = TextEditingController();

  @override
  void dispose() {
    friendContoller.dispose();
    super.dispose();
  }

  void _addPartyUser({required List<String> partyUserList}) {
    if (partyUserList.isNotEmpty) {
      context
          .blocProvider<AccountBloc>()
          .add(AddPartyUserEvent(partyUserList: partyUserList));
      _clearAuth();
    }
  }

  void _clearAuth() {
    context.blocProvider<AuthBloc>().add(const RestartEvent());
  }

  void _updateToken({required String token}) async {
    await LocalPreferences.clearToken();
    await LocalPreferences.setToken(token: token);
    _updateUser();
  }

  void _updateUser() {
    context.blocProvider<AuthBloc>().add(const GetUserEvent());
    _clearEvents();
  }

  void _clearEvents() {
    context.blocProvider<ManageDataBloc>().add(const ClearData());
    context.blocProvider<AccountBloc>().add(const ClearPartyUserEvent());
    _back();
  }

  void _back() {
    Navigator.pop(context);
  }

  void _getPartyUsers({required String value}) {
    if (value.isNotEmpty) {
      context.blocProvider<AccountBloc>().add(
            GetPartyUsersEvent(
              uid: null,
              nickName: value.firstToUpper,
              displayName: null,
            ),
          );
    } else {
      context.blocProvider<AccountBloc>().add(const ClearPartyUserEvent());
    }
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
                onPressed: () => _back(),
                child: Text(
                  'Voltar',
                  style: context.textTheme.titleMedium,
                ),
              ),
              Text(
                'Adicionar Amigo',
                style: context.textTheme.titleLarge,
              ),
              BlocBuilder<ManageDataBloc, ManageDataState>(
                builder: (context, state) {
                  if (state is PushData) {
                    return TextButton(
                      onPressed: () => _addPartyUser(
                          partyUserList: state.dataList as List<String>),
                      child: Text(
                        'Confimar',
                        style: context.textTheme.titleMedium,
                      ),
                    );
                  }
                  return TextButton(
                    onPressed: () => {},
                    child: Text(
                      'Confimar',
                      style: context.textTheme.titleMedium,
                    ),
                  );
                },
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
                onChanged: (value) => _getPartyUsers(value: value),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) => (state is GetUserSuccess &&
                    state.userModel.following?.isNotEmpty == true)
                ? PartyUserListView(
                    users: state.userModel.following!, following: true)
                : const SizedBox.shrink(),
          ),
          BlocConsumer<AccountBloc, AccountState>(
            listener: (context, state) => state is AddPartyUserSuccess
                ? _updateToken(token: state.token)
                : null,
            builder: (context, state) => (state is GetPartyUsersSuccess &&
                    state.partyUserList?.isNotEmpty == true)
                ? PartyUserListView(users: state.partyUserList!)
                : state is AccountInitial
                    ? const SizedBox.shrink()
                    : const Expanded(
                        child: Center(child: CircularProgressIndicator())),
          ),
        ],
      ),
    );
  }
}
