import 'package:date_split_app/core/usecases/usecase.dart';
import 'package:date_split_app/core/utils/typedefs.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

class Signup extends UsecaseWithParams<String, SignUpParams> {
  const Signup(this._repository);

  final AuthRepository _repository;

  @override
  EitherFuture<String> call(params) => _repository.signUp(
        email: params.email,
        displayName: params.displayName,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.displayName,
    required this.password,
  });

  const SignUpParams.empty()
      : this(
          email: '',
          displayName: '',
          password: '',
        );

  final String email;
  final String displayName;
  final String password;

  @override
  List<Object?> get props => [email, displayName, password];
}
