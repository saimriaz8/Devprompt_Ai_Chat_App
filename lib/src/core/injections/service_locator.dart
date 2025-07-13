import 'package:devprompt/src/features/settings/settings_injections.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:devprompt/src/features/promptchat/prompt_chat_injections.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());
  initWelcomeInjections();
  initPromtChatInjections();
  initSettingInjections();
}
