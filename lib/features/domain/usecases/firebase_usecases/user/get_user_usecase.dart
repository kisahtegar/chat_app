import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetUserUsecase {
  final FirebaseRepository repository;

  GetUserUsecase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUser(userEntity);
  }
}
