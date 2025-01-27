import 'package:date_split_app/core/extensions/context_extension.dart';
import 'package:date_split_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatefulWidget {
  const FollowButton({super.key, required this.uid});

  final String uid;

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollowing = false;

  void _toggleButton() {
    setState(
      () => isFollowing = !isFollowing,
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
