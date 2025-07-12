import 'package:devprompt/src/core/injections/service_locator.dart';
import 'package:devprompt/src/core/routing/app_router.dart';
import 'package:devprompt/src/core/theme/app_theme.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/pages/welcome_page.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WelcomeBloc>(create: (context) => sl<WelcomeBloc>()),
        BlocProvider<PromptchatBloc>(create: (context) => sl<PromptchatBloc>()),
      ],
      child: MaterialApp.router(
        title: 'Dev Prompt',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: goRouter,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String pageName = '/';

  @override
  Widget build(BuildContext context) {
    return WelcomePage();
  }
}
