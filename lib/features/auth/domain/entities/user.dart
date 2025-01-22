import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final String? avatar;
  final String? nickName;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    required this.avatar,
    required this.nickName,
  });

  @override
  List<Object?> get props => [uid, email, displayName, avatar, nickName];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, displayName: $displayName, avatar: $avatar, nickName: $nickName}';
  }
}
