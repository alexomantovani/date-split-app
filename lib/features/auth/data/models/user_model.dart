import 'package:date_split_app/features/auth/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.uid,
    required this.email,
    required this.displayName,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          displayName: '',
        );

  final String uid;
  final String email;
  final String displayName;

  @override
  List<Object?> get props => [uid, email, displayName];

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, displayName: $displayName}';
  }

  // Métodos para conversão da camada de dados:
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
    );
  }

  User toEntity() {
    return User(
      uid: uid,
      email: email,
      displayName: displayName,
    );
  }

  // Métodos de serialização para JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
    };
  }
}
