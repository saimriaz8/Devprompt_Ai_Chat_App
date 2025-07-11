import 'package:devprompt/src/features/welcome/domain/repositories/abstract_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignInWithGoogleUsecase {
  final AuthRepository _authRepository;
  SignInWithGoogleUsecase(this._authRepository);

  Future<User?> call() async {
    return _authRepository.signInWithGoogle();
  }
}
