import 'package:equatable/equatable.dart';

class PartyUser extends Equatable {
  final String uid;
  final String email;
  final String? nickName;
  final String? avatar;
  final List<String>? parties;

  const PartyUser({
    required this.uid,
    required this.email,
    required this.nickName,
    required this.avatar,
    required this.parties,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        nickName,
        avatar,
        parties,
      ];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return 'PartyUser{uid: $uid, email: $email, avatar: $avatar, nickName: $nickName, parties: $parties}';
  }
}
