import 'package:flutter_test/flutter_test.dart';

import 'package:date_split_app/core/common/features/account/data/models/party_user_model.dart';
import 'package:date_split_app/core/common/features/account/domain/entities/party_user.dart';

void main() {
  const partyUserModel = PartyUserModel.empty();
  const partyUserEntity = PartyUser(
    uid: 'testUid123',
    email: 'test@example.com',
    avatar: null,
    nickName: null,
    parties: null,
  );

  group('UserModel', () {
    test('should convert from [PartyUser] entity correctly', () {
      // Arrange

      // Act
      final model = PartyUserModel.fromEntity(partyUserEntity);

      // Assert
      expect(model.uid, partyUserEntity.uid);
      expect(model.email, partyUserEntity.email);
      expect(model.avatar, partyUserEntity.avatar);
      expect(model.nickName, partyUserEntity.nickName);
      expect(model.parties, partyUserEntity.parties);
    });

    test('should convert to User entity correctly', () {
      // Act
      final entity = partyUserModel.toEntity();

      // Assert
      expect(entity.uid, partyUserModel.uid);
      expect(entity.email, partyUserModel.email);
      expect(entity.avatar, partyUserModel.avatar);
      expect(entity.nickName, partyUserModel.nickName);
      expect(entity.parties, partyUserModel.parties);
    });

    test('should convert from JSON correctly', () {
      // Arrange
      final json = {
        'uid': 'testUid123',
        'email': 'test@example.com',
        'avatar': null,
        'nickName': null,
        'parties': [''],
      };

      // Act
      final model = PartyUserModel.fromJson(json);

      // Assert
      expect(model.uid, json['uid']);
      expect(model.email, json['email']);
      expect(model.avatar, json['avatar']);
      expect(model.nickName, json['nickName']);
      expect(model.parties, json['parties']);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = partyUserModel.toJson();

      // Assert
      expect(json['uid'], partyUserModel.uid);
      expect(json['email'], partyUserModel.email);
      expect(json['avatar'], partyUserModel.avatar);
      expect(json['nickName'], partyUserModel.nickName);
      expect(json['parties'], partyUserModel.parties);
    });

    test('should return an empty PartyUserModel correctly', () {
      // Act
      const emptyModel = PartyUserModel.empty();

      // Assert
      expect(emptyModel.uid, '');
      expect(emptyModel.email, '');
      expect(emptyModel.avatar, null);
      expect(emptyModel.nickName, null);
      expect(emptyModel.parties, null);
    });

    test('should support value comparison with Equatable', () {
      // Arrange
      const anotherUserModel = PartyUserModel(
        uid: '',
        email: '',
        avatar: null,
        nickName: null,
        parties: null,
      );

      // Assert
      expect(partyUserModel, equals(anotherUserModel));
    });

    test('should have correct toString implementation', () {
      // Assert
      expect(
        partyUserModel.toString(),
        'PartyUserModel(uid: , email: , nickName: null, avatar: null, parties: null)',
      );
    });
  });
}
