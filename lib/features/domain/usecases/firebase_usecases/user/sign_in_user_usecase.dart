import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class SignInUserUsecase {
  final FirebaseRepository repository;

  SignInUserUsecase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.signInUser(userEntity);
  }
}
