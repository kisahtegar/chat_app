import '../../../entities/user/user_entity.dart';
import '../../../repositories/firebase_repository.dart';

class IsSignInUsecase {
  final FirebaseRepository repository;

  IsSignInUsecase({required this.repository});

  Future<bool> call() {
    return repository.isSignIn();
  }
}
