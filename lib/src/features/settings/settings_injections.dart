import 'package:devprompt/src/features/settings/auth/domain/settings_auth_usecase.dart';
import 'package:devprompt/src/features/settings/data/repositories/auth_repository_implementation.dart';
import 'package:devprompt/src/features/settings/domain/repositories/abstract_auth_repository.dart';
import 'package:devprompt/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void initSettingInjections() {
  sl.registerLazySingleton<SettingsAuthRepository>(
    () => AuthRepositoryImplementation(
      googleSignIn: sl<GoogleSignIn>(),
      firebaseAuth: sl<FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<SignOutUserUsecase>(() => SignOutUserUsecase(sl()));
  sl.registerFactory<SettingsBloc>(() => SettingsBloc());
}
