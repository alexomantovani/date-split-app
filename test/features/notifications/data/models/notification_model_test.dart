import 'package:date_split_app/features/notifications/data/models/notification_model.dart';
import 'package:date_split_app/features/notifications/domain/entities/notification.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date = DateTime.now();
  final notificationModel = NotificationModel(
    id: 'testNotificationId123',
    title: 'Test Title',
    body: 'This is a test notification body.',
    tokens: const ['token1', 'token2'],
    createdAt: date,
    updatedAt: date,
  );

  group('NotificationModel', () {
    test('should convert from Notification entity correctly', () {
      // Arrange
      final notificationEntity = Notification(
        id: 'testNotificationId123',
        title: 'Test Title',
        body: 'This is a test notification body.',
        tokens: const ['token1', 'token2'],
        createdAt: date,
        updatedAt: date,
      );

      // Act
      final model = NotificationModel.fromEntity(notificationEntity);

      // Assert
      expect(model.id, notificationEntity.id);
      expect(model.title, notificationEntity.title);
      expect(model.body, notificationEntity.body);
      expect(model.tokens, notificationEntity.tokens);
      expect(model.createdAt, notificationEntity.createdAt);
      expect(model.updatedAt, notificationEntity.updatedAt);
    });

    test('should convert to Notification entity correctly', () {
      // Act
      final entity = notificationModel.toEntity();

      // Assert
      expect(entity.id, notificationModel.id);
      expect(entity.title, notificationModel.title);
      expect(entity.body, notificationModel.body);
      expect(entity.tokens, notificationModel.tokens);
      expect(entity.createdAt, notificationModel.createdAt);
      expect(entity.updatedAt, notificationModel.updatedAt);
    });

    test('should convert from JSON correctly', () {
      // Arrange
      final Map<String, dynamic> json = {
        'id': 'testNotificationId123',
        'title': 'Test Title',
        'body': 'This is a test notification body.',
        'tokens': ['token1', 'token2'],
        'createdAt': date.toIso8601String(),
        'updatedAt': date.toIso8601String(),
      };

      // Act
      final model = NotificationModel.fromJson(json);

      // Assert
      expect(model.id, json['id']);
      expect(model.title, json['title']);
      expect(model.body, json['body']);
      expect(model.tokens, json['tokens']);
      expect(model.createdAt, DateTime.parse(json['createdAt']));
      expect(model.updatedAt, DateTime.parse(json['updatedAt']));
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = notificationModel.toJson();

      // Assert
      expect(json['id'], notificationModel.id);
      expect(json['title'], notificationModel.title);
      expect(json['body'], notificationModel.body);
      expect(json['tokens'], notificationModel.tokens);
      expect(json['createdAt'], notificationModel.createdAt.toIso8601String());
      expect(json['updatedAt'], notificationModel.updatedAt.toIso8601String());
    });

    test('should return an empty NotificationModel correctly', () {
      // Act
      final emptyModel = NotificationModel.empty();

      // Assert
      expect(emptyModel.id, '');
      expect(emptyModel.title, '');
      expect(emptyModel.body, '');
      expect(emptyModel.tokens, []);
      expect(emptyModel.createdAt, DateTime(1970, 1, 1));
      expect(emptyModel.updatedAt, DateTime(1970, 1, 1));
    });

    test('should support value comparison with Equatable', () {
      // Arrange
      final anotherNotificationModel = NotificationModel(
        id: 'testNotificationId123',
        title: 'Test Title',
        body: 'This is a test notification body.',
        tokens: const ['token1', 'token2'],
        createdAt: date,
        updatedAt: date,
      );

      // Assert
      expect(notificationModel, equals(anotherNotificationModel));
    });

    test('should have correct toString implementation', () {
      // Assert
      expect(
        notificationModel.toString(),
        'NotificationModel{id: testNotificationId123, title: Test Title, body: This is a test notification body., tokens: [token1, token2], createdAt: $date, updatedAt: $date}',
      );
    });
  });
}
