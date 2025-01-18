import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccount extends UsecaseWithParams<void, String> {
  const DeleteAccount(this._repository);

  final AuthRepository _repository;

  @override
  EitherFuture<String> call(String params) =>
      _repository.deleteAccount(uid: params);
}
