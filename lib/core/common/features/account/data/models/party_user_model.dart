import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';

class PartyUserModel extends PartyUser {
  const PartyUserModel({
    required super.uid,
    required super.email,
    super.nickName,
    super.avatar,
    super.parties,
  });

  const PartyUserModel.empty()
      : this(
          uid: '',
          email: '',
          avatar: null,
          nickName: null,
          parties: null,
        );

  @override
  List<Object?> get props => [uid, nickName, email, avatar, parties];

  @override
  String toString() {
    return 'PartyUserModel(uid: $uid, email: $email, nickName: $nickName, avatar: $avatar, parties: $parties)';
  }

// Métodos para conversão da camada de dados:
  factory PartyUserModel.fromEntity(PartyUser user) {
    return PartyUserModel(
      uid: user.uid,
      email: user.email,
      avatar: user.avatar,
      nickName: user.nickName,
      parties: user.parties,
    );
  }

  PartyUser toEntity() {
    return PartyUser(
      uid: uid,
      email: email,
      avatar: avatar,
      nickName: nickName,
      parties: parties,
    );
  }

  // Métodos de serialização para JSON
  factory PartyUserModel.fromJson(Map<String, dynamic> json) {
    return PartyUserModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      avatar: json['avatar'],
      nickName: json['nickName'],
      parties: json['parties'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'avatar': avatar,
      'nickName': nickName,
      'parties': parties,
    };
  }
}
