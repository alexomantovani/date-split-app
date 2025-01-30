import 'package:flutter/material.dart';

import 'package:date_split_app/core/common/features/account/presentation/bloc/manage/manage_data_bloc.dart';
import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/styles.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key, required this.uid, this.following});

  final String uid;
  final bool? following;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  @override
  void initState() {
    _initFollowingData();
    super.initState();
  }

  void _initFollowingData() {
    if (widget.following != null) {
      setState(() => isFollowing = !isFollowing);
    }
  }

  void _toggleButton() {
    setState(() => isFollowing = !isFollowing);
    context.blocProvider<ManageDataBloc>().add(
          SelectData(data: widget.uid),
        );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _toggleButton,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isFollowing ? Colors.transparent : Styles.kStandardConfirm,
        side: isFollowing ? const BorderSide(color: Styles.kPrimaryText) : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 0.0,
        ),
        elevation: 0.0,
      ),
      child: Text(
        isFollowing ? 'Seguindo' : 'Seguir',
        style: isFollowing
            ? context.textTheme.titleSmall
            : context.textTheme.titleSmall!
                .copyWith(color: Styles.kStandardWhite),
      ),
    );
  }
}
