import 'package:date_split_app/core/utils/constants.dart';
import 'package:date_split_app/features/auth/presentation/widgets/confirm_action_button.dart';
import 'package:date_split_app/features/auth/presentation/widgets/identification_card.dart';
import 'package:flutter/material.dart';

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
            backGroundColor: kPrimaryBlue,
            label: 'Novo Role',
            onPressed: () {},
          ),
          Container(
            margin: const EdgeInsets.all(12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: const BoxDecoration(
              color: kStandardWhite,
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
                  unselectedLabelColor: kDescriptionText,
                  labelColor: kPrimaryText,
                  labelStyle: TextTheme.of(context).titleLarge,
                  tabs: const [
                    Text('Amigos'),
                    Text('Rolês'),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: TabBarView(
                    controller: _tabControler,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: Column(
                          children: [
                            Image.asset(kMeditating),
                            Text(
                              'Sem amigos por aqui',
                              style: TextTheme.of(context).titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Convide amigos para desbloquear funcionalidades',
                              style: TextTheme.of(context).bodyMedium,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 120.0),
                        child: Column(
                          children: [
                            Image.asset(kPlant),
                            Text(
                              'Sem rolês por aqui',
                              style: TextTheme.of(context).titleLarge,
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Convide rolês para desbloquear funcionalidades',
                              style: TextTheme.of(context).bodyMedium,
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
