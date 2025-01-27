import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:date_split_app/core/common/features/account/presentation/bloc/account/account_bloc.dart';
import 'package:date_split_app/core/common/features/account/presentation/views/add_user_page.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/identification_card.dart';
import 'package:date_split_app/core/common/widgets/confirm_action_button.dart';
import 'package:date_split_app/core/common/widgets/custom_field.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';
import 'package:date_split_app/core/utils/core_utils.dart';
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
                                        itemCount:
                                            state.userModel.following!.length,
                                        itemBuilder: (context, index) => Row(
                                          children: [
                                            SizedBox(
                                              height: 82,
                                              width: 82,
                                              child: Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                      Assets.toAssetPath(
                                                          asset: state
                                                              .userModel
                                                              .following![index]
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state
                                                          .userModel
                                                          .following![index]
                                                          .nickName ??
                                                      '',
                                                  style: context
                                                      .textTheme.titleLarge,
                                                ),
                                                Text(
                                                  'ID ${state.userModel.following![index].uid.substring((state.userModel.following![index].uid.length / 2).toInt())}',
                                                  style: context
                                                      .textTheme.bodyMedium,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                          style: theme.titleLarge,
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          'Convide amigos para desbloquear funcionalidades',
                                          style: theme.bodyMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    );
                                  }
                                } else if (state is AccountError ||
                                    state is AccountInitial) {
                                  return Column(
                                    children: [
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
