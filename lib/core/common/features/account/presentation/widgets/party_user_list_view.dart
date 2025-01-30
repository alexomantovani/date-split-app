import 'package:flutter/material.dart';

import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:date_split_app/core/common/features/account/presentation/widgets/follow_button.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/assets.dart';

class PartyUserListView extends StatelessWidget {
  const PartyUserListView({
    super.key,
    required this.users,
    this.following,
  });

  final List<PartyUser> users;
  final bool? following;

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) return const SizedBox.shrink();

    return Flexible(
      fit: FlexFit.loose,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Row(
            children: [
              SizedBox(
                height: 82,
                width: 82,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.toAssetPath(asset: user.avatar)),
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
                  padding: const EdgeInsets.only(left: 10.0, right: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        user.nickName?.isNotEmpty == true ? user.nickName! : '',
                        style: context.textTheme.titleLarge,
                      ),
                      FollowButton(
                        uid: user.uid,
                        following: following,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
