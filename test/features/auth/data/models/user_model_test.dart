import 'package:flutter_test/flutter_test.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/entities/user.dart';

void main() {
  const userModel = UserModel(
    uid: 'testUid123',
    email: 'test@example.com',
    displayName: 'Test User',
    avatar: null,
    nickName: null,
    following: null,
    parties: null,
  );

  group('UserModel', () {
    test('should convert from User entity correctly', () {
      // Arrange
      const userEntity = User(
        uid: 'testUid123',
        email: 'test@example.com',
        displayName: 'Test User',
        avatar: null,
        nickName: null,
        following: null,
        parties: null,
      );

      // Act
      final model = UserModel.fromEntity(userEntity);

      // Assert
      expect(model.uid, userEntity.uid);
      expect(model.email, userEntity.email);
      expect(model.displayName, userEntity.displayName);
    });

    test('should convert to User entity correctly', () {
      // Act
      final entity = userModel.toEntity();

      // Assert
      expect(entity.uid, userModel.uid);
      expect(entity.email, userModel.email);
      expect(entity.displayName, userModel.displayName);
      expect(entity.avatar, userModel.avatar);
      expect(entity.nickName, userModel.nickName);
    });

    test('should convert from JSON correctly', () {
      // Arrange
      final json = {
        'uid': 'testUid123',
        'email': 'test@example.com',
        'displayName': 'Test User',
        'avatar': null,
        'nickName': null,
        'following': null,
      };

      // Act
      final model = UserModel.fromJson(json);

      // Assert
      expect(model.uid, json['uid']);
      expect(model.email, json['email']);
      expect(model.displayName, json['displayName']);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = userModel.toJson();

      // Assert
      expect(json['uid'], userModel.uid);
      expect(json['email'], userModel.email);
      expect(json['displayName'], userModel.displayName);
    });

    test('should return an empty UserModel correctly', () {
      // Act
      const emptyModel = UserModel.empty();

      // Assert
      expect(emptyModel.uid, '');
      expect(emptyModel.email, '');
      expect(emptyModel.displayName, '');
    });

    test('should support value comparison with Equatable', () {
      // Arrange
      const anotherUserModel = UserModel(
        uid: 'testUid123',
        email: 'test@example.com',
        displayName: 'Test User',
        avatar: null,
        nickName: null,
        following: null,
        parties: null,
      );

      // Assert
      expect(userModel, equals(anotherUserModel));
    });

    test('should have correct toString implementation', () {
      // Assert
      expect(
        userModel.toString(),
        'UserModel{uid: testUid123, email: test@example.com, displayName: Test User, avatar: null, nickName: null, following: null, parties: null}',
      );
    });
  });
}
