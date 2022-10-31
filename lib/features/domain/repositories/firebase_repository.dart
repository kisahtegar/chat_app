import 'package:chat_app/features/domain/entities/user/user_entity.dart';

abstract class FirebaseRepository {
  // CREDENTIAL
  Future<void> signInUser(UserEntity userEntity);
  Future<void> signUpUser(UserEntity userEntity);
  Future<bool> isSignIn();
  Future<void> signOut();

  // USER
  Stream<List<UserEntity>> getUsers(UserEntity userEntity);
  Stream<List<UserEntity>> getSingleUsers(String uid);
  Future<String> getCurrentUid();
  Future<void> createUser(UserEntity userEntity);
  Future<void> updateUser(UserEntity userEntity);
}
