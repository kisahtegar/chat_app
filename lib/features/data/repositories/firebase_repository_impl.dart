import '../../domain/entities/user/user_entity.dart';
import '../../domain/repositories/firebase_repository.dart';
import '../data_sources/remote_data_source/firebase_remote_data_source.dart';

class FirebaseRepositoryImpl implements FirebaseRepository {
  final FirebaseRemoteDatasource remoteDatasource;

  FirebaseRepositoryImpl({required this.remoteDatasource});

  @override
  Future<void> createUser(UserEntity userEntity) async =>
      remoteDatasource.createUser(userEntity);

  @override
  Future<String> getCurrentUid() async => remoteDatasource.getCurrentUid();

  @override
  Stream<List<UserEntity>> getSingleUsers(String uid) =>
      remoteDatasource.getSingleUser(uid);

  @override
  Stream<List<UserEntity>> getUsers(UserEntity userEntity) =>
      remoteDatasource.getUsers(userEntity);

  @override
  Future<bool> isSignIn() async => remoteDatasource.isSignIn();

  @override
  Future<void> signInUser(UserEntity userEntity) async =>
      remoteDatasource.signInUser(userEntity);

  @override
  Future<void> signOut() async => remoteDatasource.signOut();

  @override
  Future<void> signUpUser(UserEntity userEntity) async =>
      remoteDatasource.signUpUser(userEntity);

  @override
  Future<void> updateUser(UserEntity userEntity) async =>
      remoteDatasource.updateUser(userEntity);
}
