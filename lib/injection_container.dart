import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';

import 'features/data/data_sources/remote_data_source/firebase_remote_data_source.dart';
import 'features/data/data_sources/remote_data_source/firebase_remote_data_source_impl.dart';
import 'features/data/repositories/firebase_repository_impl.dart';
import 'features/domain/repositories/firebase_repository.dart';
import 'features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/create_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/get_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/is_sign_in_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/sign_in_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/sign_out_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/sign_up_user_usecase.dart';
import 'features/domain/usecases/firebase_usecases/user/update_user_usecase.dart';
import 'features/presentation/cubit/auth/auth_cubit.dart';
import 'features/presentation/cubit/credential/credential_cubit.dart';
import 'features/presentation/cubit/user/get_single_users/get_single_user_cubit.dart';
import 'features/presentation/cubit/user/user_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // cubit
  sl.registerFactory(
    () => AuthCubit(
      signOutUsecase: sl.call(),
      isSignInUsecase: sl.call(),
      getCurrentUidUsecase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => CredentialCubit(
      signInUserUsecase: sl.call(),
      signUpUserUseCase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => UserCubit(
      updateUserUsecase: sl.call(),
      getUserUsecase: sl.call(),
    ),
  );
  sl.registerFactory(
    () => GetSingleUserCubit(
      getSingleUserUsecase: sl.call(),
    ),
  );

  // Usecases User
  sl.registerLazySingleton(() => CreateUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetCurrentUidUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetSingleUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => GetUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => IsSignInUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignInUserUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignOutUsecase(repository: sl.call()));
  sl.registerLazySingleton(() => SignUpUserUseCase(repository: sl.call()));
  sl.registerLazySingleton(() => UpdateUserUsecase(repository: sl.call()));

  // Usecases Storage
  sl.registerLazySingleton(
      () => UploadImageToStorageUsecase(repository: sl.call()));

  // Repositories
  sl.registerLazySingleton<FirebaseRepository>(
    () => FirebaseRepositoryImpl(
      remoteDatasource: sl.call(),
    ),
  );

  // remote_data_source
  sl.registerLazySingleton<FirebaseRemoteDatasource>(
    () => FirebaseRemoteDataSourceImpl(
      firebaseFirestore: sl.call(),
      firebaseAuth: sl.call(),
      firebaseStorage: sl.call(),
    ),
  );

  // Externals
  final firebaseFirestore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStorage = FirebaseStorage.instance;

  sl.registerLazySingleton(() => firebaseFirestore);
  sl.registerLazySingleton(() => firebaseAuth);
  sl.registerLazySingleton(() => firebaseStorage);
}
