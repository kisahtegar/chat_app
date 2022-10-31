import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class CreateUserUsecase {
  final FirebaseRepository repository;

  CreateUserUsecase({required this.repository});

  Future<void> call(UserEntity userEntity) {
    return repository.createUser(userEntity);
  }
}
