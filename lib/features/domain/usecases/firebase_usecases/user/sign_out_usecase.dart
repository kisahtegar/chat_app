import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class SignOutUsecase {
  final FirebaseRepository repository;

  SignOutUsecase({required this.repository});

  Future<void> call() {
    return repository.signOut();
  }
}
