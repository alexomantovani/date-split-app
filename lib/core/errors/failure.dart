import 'package:date_split_app/core/errors/exception.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure({required this.message, required this.statusCode});

  final String message;
  final dynamic statusCode;

  String get errorMessage {
    final showErrorText =
        statusCode! is String || int.tryParse(statusCode as String) != null;
    return '$statusCode${showErrorText ? ' Error' : ''}: $message';
  }

  @override
  List<Object> get props => [message, statusCode];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  ServerFailure.fromException(ServerException exception)
      : this(message: exception.message, statusCode: exception.statusCode);
}

class UnknownFailure extends Failure {
  final String? cause;

  const UnknownFailure(
      {required super.message, this.cause, required super.statusCode});

  @override
  String toString() {
    return 'UnknownFailure: $message - Cause: ${cause ?? 'Unknown cause'}';
  }
}
