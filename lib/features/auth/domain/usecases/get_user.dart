import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/data/models/user_model.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class GetUser extends UsecaseWithoutParams {
  const GetUser(this._repository);

  final AuthRepository _repository;

  @override
  EitherFuture<UserModel> call() => _repository.getUser();
}
