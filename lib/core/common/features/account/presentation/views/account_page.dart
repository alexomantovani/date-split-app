import 'package:flutter/material.dart';

import 'package:date_split_app/core/common/features/account/presentation/views/party_tab_view.dart';
import 'package:date_split_app/core/common/features/account/presentation/views/party_user_tab_view.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/identification_card.dart';
import 'package:date_split_app/core/common/widgets/confirm_action_button.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabControler;

  @override
  void initState() {
    super.initState();
    _tabControler = TabController(length: 2, vsync: this);
    (context).blocProvider<AuthBloc>().add(const GetUserEvent());
  }

  @override
  void dispose() {
    _tabControler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const IdentificationCard(),
          ConfirmActionButton(
            padding: const EdgeInsets.all(12.0),
            type: ButtonType.add,
            backGroundColor: Styles.kPrimaryBlue,
            label: 'Novo Role',
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: Styles.kStandardWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                TabBar(
                  controller: _tabControler,
                  dividerColor: Colors.transparent,
                  unselectedLabelColor: Styles.kDescriptionText,
                  labelColor: Styles.kPrimaryText,
                  labelStyle: context.textTheme.titleLarge,
                  indicatorColor: Styles.kPrimaryBlue,
                  tabs: const [
                    Text('Amigos'),
                    Text('Roles'),
                  ],
                ),
                SizedBox(
                  height: context.height,
                  child: TabBarView(
                    controller: _tabControler,
                    children: const [
                      PartyUserTabView(),
                      PartyTabView(),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
