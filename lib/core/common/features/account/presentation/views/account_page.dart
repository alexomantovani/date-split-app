import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:date_split_app/core/common/widgets/confirm_action_button.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/identification_card.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabControler;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController friendContoller = TextEditingController();
  late TextTheme theme;

  @override
  void initState() {
    super.initState();
    _tabControler = TabController(length: 2, vsync: this);
    (context).blocProvider<AuthBloc>().add(const GetUserEvent());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = context.textTheme;
  }

  @override
  void dispose() {
    _tabControler.dispose();
    friendContoller.dispose();
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
                  labelStyle: theme.titleLarge,
                  indicatorColor: Styles.kPrimaryBlue,
                  tabs: const [
                    Text('Amigos'),
                    Text('Rolês'),
                  ],
                ),
                SizedBox(
                  height: context.height,
                  child: TabBarView(
                    controller: _tabControler,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Form(
                                    key: _formKey,
                                    child: CustomField(
                                      controller: friendContoller,
                                      filled: true,
                                      fillColour: Styles.kBgField,
                                      enabledBorderColor:
                                          Styles.kDescriptionText,
                                      prefixIcon: const Icon(Icons.search),
                                      hintText: 'Precure Amigos',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                SvgPicture.asset(Assets.kIcAddUser),
                                const SizedBox(width: 10.0),
                                SvgPicture.asset(Assets.kIcFilterList),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Image.asset(Assets.kMeditating),
                            Text(
                              'Sem amigos por aqui',
                              style: theme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Convide amigos para desbloquear funcionalidades',
                              style: theme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: Column(
                          children: [
                            Image.asset(Assets.kPlant),
                            Text(
                              'Sem rolês por aqui',
                              style: theme.titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Convide rolês para desbloquear funcionalidades',
                              style: theme.bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
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
