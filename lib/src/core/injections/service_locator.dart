import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:devprompt/src/features/promptchat/prompt_chat_injections.dart';
import 'package:dio/dio.dart';

Dio _createDio() {
  final dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );
  return dio;
}

void init() {
  sl.registerLazySingleton<Dio>(() => _createDio());
  initWelcomeInjections();
  initPromtChatInjections();
}
