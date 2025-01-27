import 'package:date_split_app/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    required super.avatar,
    required super.nickName,
    required super.following,
  });

  const UserModel.empty()
      : this(
          uid: '',
          email: '',
          displayName: '',
          avatar: null,
          nickName: null,
          following: null,
        );

  @override
  List<Object?> get props => [uid, email, displayName, avatar, nickName];

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, displayName: $displayName, avatar: $avatar, nickName: $nickName}';
  }

  // Métodos para conversão da camada de dados:
  factory UserModel.fromEntity(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      avatar: user.avatar,
      nickName: user.nickName,
      following: user.following,
    );
  }

  User toEntity() {
    return User(
      uid: uid,
      email: email,
      displayName: displayName,
      avatar: avatar,
      nickName: nickName,
      following: following,
    );
  }

  // Métodos de serialização para JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
      avatar: json['avatar'],
      nickName: json['nickName'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'avatar': avatar,
      'nickName': nickName,
      'following': following,
    };
  }
}
