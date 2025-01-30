import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? avatar;
  final String? nickName;
  final List<PartyUser>? following;
  final List<dynamic>? parties;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.avatar,
    required this.nickName,
    required this.following,
    required this.parties,
  });

  @override
  List<Object?> get props =>
      [uid, email, displayName, avatar, nickName, following, parties];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, displayName: $displayName, avatar: $avatar, nickName: $nickName, following: $following, parties: $parties}';
  }
}
