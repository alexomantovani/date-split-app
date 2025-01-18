import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class ResetPassword extends UsecaseWithParams<void, String> {
  const ResetPassword(this._repository);

  final AuthRepository _repository;

  @override
  EitherFuture<String> call(String params) =>
      _repository.resetPassword(email: params);
}
