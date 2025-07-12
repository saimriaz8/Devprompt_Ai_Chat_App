import 'package:devprompt/src/features/promptchat/data/datasource/remote/ai_prompt_remote_datasource.dart';
import 'package:devprompt/src/features/promptchat/data/repositories/ai_prompt_repository_implementation.dart';
import 'package:devprompt/src/features/promptchat/domain/repositories/abstract_ai_prompt_repository.dart';
import 'package:devprompt/src/features/promptchat/domain/usecases/ai_prompt_response_usecase.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:dio/dio.dart';


void initPromtChatInjections() {
  sl.registerLazySingleton<AiPromptRemoteDatasource>(
    () => AiPromptRemoteDatasourceImplementation(sl<Dio>()),
  );
  sl.registerLazySingleton<AiPromptRepository>(
    () => AiPromptRepositoryImplementation(sl()),
  );
  sl.registerLazySingleton<AiPromptResponseUsecase>(
    () => AiPromptResponseUsecase(sl()),
  );

  sl.registerFactory<PromptchatBloc>(() => PromptchatBloc(sl()));
}
