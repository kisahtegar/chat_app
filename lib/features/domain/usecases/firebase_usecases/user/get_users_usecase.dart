import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetUsersUsecase {
  final FirebaseRepository repository;

  GetUsersUsecase({required this.repository});

  Stream<List<UserEntity>> call(UserEntity userEntity) {
    return repository.getUsers(userEntity);
  }
}
