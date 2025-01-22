import 'package:equatable/equatable.dart';

import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';

class UpdateUser extends UsecaseWithParams<String, UpdateUserParams> {
  const UpdateUser(this._repository);

  final AuthRepository _repository;

  @override
  EitherFuture<String> call(params) => _repository.updateUser(
        token: params.token,
        avatar: params.avatar,
        nickName: params.nickName,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({
    required this.token,
    required this.avatar,
    required this.nickName,
  });

  final String? token;
  final String? avatar;
  final String? nickName;

  const UpdateUserParams.empty()
      : this(
          token: '',
          avatar: '',
          nickName: '',
        );

  @override
  List<Object?> get props => [token];
}
