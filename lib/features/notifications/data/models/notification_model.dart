import 'package:date_split_app/features/notifications/domain/entities/notification.dart';

class NotificationModel extends Notification {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.tokens,
    required super.createdAt,
    required super.updatedAt,
  });

  NotificationModel.empty()
      : this(
          id: '',
          title: '',
          body: '',
          tokens: const [],
          createdAt: DateTime(1970, 1, 1),
          updatedAt: DateTime(1970, 1, 1),
        );

  @override
  List<Object?> get props => [id, title, body, tokens, createdAt, updatedAt];

  @override
  String toString() {
    return 'NotificationModel{id: $id, title: $title, body: $body, tokens: $tokens, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  // Métodos para conversão da camada de dados:
  factory NotificationModel.fromEntity(Notification notification) {
    return NotificationModel(
      id: notification.id,
      title: notification.title,
      body: notification.body,
      tokens: notification.tokens,
      createdAt: notification.createdAt,
      updatedAt: notification.updatedAt,
    );
  }

  Notification toEntity() {
    return Notification(
      id: id,
      title: title,
      body: body,
      tokens: tokens,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Métodos de serialização para JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      tokens: List<String>.from(json['tokens'] as List<dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'tokens': tokens,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
