import 'package:devprompt/src/features/welcome/data/repositories/auth_repository_implementation.dart';
import 'package:devprompt/src/features/welcome/domain/repositories/abstract_auth_repository.dart';
import 'package:devprompt/src/features/welcome/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void initWelcomeInjections() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImplementation(),
  );
  sl.registerLazySingleton<SignInWithGoogleUsecase>(
    () => SignInWithGoogleUsecase(sl()),
  );
  sl.registerFactory<WelcomeBloc>(() => WelcomeBloc(sl()));
}
