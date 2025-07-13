import 'package:devprompt/src/core/injections/service_locator.dart';
import 'package:devprompt/src/core/routing/app_router.dart';
import 'package:devprompt/src/core/theme/app_theme.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/pages/welcome_page.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load();
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
        BlocProvider<SettingsBloc>(create: (context) => sl<SettingsBloc>()),
      ],
      child: Builder(
        builder: (context) {
          final isLight =
              context.watch<SettingsBloc>().state is SettingsLightModeState;
          return MaterialApp.router(
            title: 'Dev Prompt',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            themeMode:
                isLight
                    ? ThemeMode.light
                    : ThemeMode.dark,
            routerConfig: goRouter,
          );
        },
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
