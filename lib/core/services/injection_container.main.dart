part of 'injection_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await authInit();
  await avatarInit();
  await accountInit();
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

Future<void> accountInit() async {
  sl
    ..registerFactory(
      () => AccountBloc(
        getPartyUsers: sl<GetPartyUsers>(),
        addPartyUsers: sl<AddPartyUsers>(),
      ),
    )
    ..registerFactory(
      () => ManageDataBloc(
        dataList: sl<List<String>>(),
      ),
    )
    ..registerLazySingleton<List<String>>(() => [])
    ..registerLazySingleton(() => GetPartyUsers(sl()))
    ..registerLazySingleton(() => AddPartyUsers(sl()))
    ..registerLazySingleton<AccountRepository>(
        () => AccountRepositoryImpl(sl()))
    ..registerLazySingleton<AccountRemoteDataSource>(
      () => AccountRemoteDataSourceImpl(
        baseUrl: sl(),
        client: sl(),
      ),
    );
}
