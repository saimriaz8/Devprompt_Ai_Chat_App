import 'package:devprompt/src/features/settings/domain/repositories/abstract_auth_repository.dart';

class SignOutUserUsecase {
  final SettingsAuthRepository settingsAuthRepository;
  SignOutUserUsecase(this.settingsAuthRepository);

  Future<void> call() async {
    await settingsAuthRepository.signOut();
  }
}
