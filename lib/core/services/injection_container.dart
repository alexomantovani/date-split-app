import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'package:date_split_app/core/common/features/account/presentation/bloc/configuration_bloc.dart';
import 'package:date_split_app/core/environments/environments.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:date_split_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:date_split_app/features/auth/data/repositories/auth_repository_implementation.dart';
import 'package:date_split_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:date_split_app/features/auth/domain/usecases/delete_account.dart';
import 'package:date_split_app/features/auth/domain/usecases/get_user.dart';
import 'package:date_split_app/features/auth/domain/usecases/reset_password.dart';
import 'package:date_split_app/features/auth/domain/usecases/signin.dart';
import 'package:date_split_app/features/auth/domain/usecases/signup.dart';
import 'package:date_split_app/features/auth/domain/usecases/update_user.dart';
import 'package:date_split_app/features/auth/presentation/bloc/auth_bloc.dart';

part 'injection_container.main.dart';
