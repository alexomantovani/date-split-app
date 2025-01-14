import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

  @override
  String toString() {
    return 'User{uid: $uid, email: $email, displayName: $displayName}';
  }
}
