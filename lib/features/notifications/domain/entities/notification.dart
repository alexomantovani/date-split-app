import 'package:equatable/equatable.dart';

class Notification extends Equatable {
  final String id;
  final String title;
  final String body;
  final List<String> tokens;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Notification({
    required this.id,
    required this.title,
    required this.body,
    required this.tokens,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id, title, body, tokens, createdAt, updatedAt];

  @override
  bool? get stringify => true;

  @override
  String toString() {
    return 'Notification(id: $id, title: $title, body: $body, tokens: $tokens, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
