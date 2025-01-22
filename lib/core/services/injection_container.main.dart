part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInit();
  await avatarInit();
}

Future<void> authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        signup: sl(),
        signIn: sl(),
        resetPassword: sl(),
        deleteAccount: sl(),
        getUser: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(() => Signup(sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton(() => UpdateUser(sl()))
    ..registerLazySingleton(() => ResetPassword(sl()))
    ..registerLazySingleton(() => DeleteAccount(sl()))
    ..registerLazySingleton(() => GetUser(sl()))
    ..registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImplementation(sl(), sl()))
    ..registerLazySingleton<AuthLocalDataSource>(
        () => const AuthLocalDataSourceImpl())
    ..registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
              client: sl(),
              baseUrl: sl(),
            ))
    ..registerLazySingleton(() => http.Client())
    ..registerLazySingleton(() => Environments.dev);
}

Future<void> avatarInit() async {
  sl.registerFactory(
    () => ConfigurationBloc(
      avatar: sl<String>(),
      nickName: sl<String>(),
    ),
  );
}
