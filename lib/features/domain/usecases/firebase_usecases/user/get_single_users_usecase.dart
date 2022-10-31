import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class GetSingleUsersUsecase {
  final FirebaseRepository repository;

  GetSingleUsersUsecase({required this.repository});

  Stream<List<UserEntity>> call(String uid) {
    return repository.getSingleUsers(uid);
  }
}
