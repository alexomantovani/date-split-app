part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInit();
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
      ),
    )
    ..registerLazySingleton(() => Signup(sl()))
    ..registerLazySingleton(() => SignIn(sl()))
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
    ..registerLazySingleton(() => kLocalBaseUrl);
}
