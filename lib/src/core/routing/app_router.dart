import 'package:devprompt/main.dart';
import 'package:devprompt/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:devprompt/src/features/promptchat/presentation/pages/promptchat_page.dart';
import 'package:devprompt/src/features/settings/presentation/pages/settings_page.dart';
import 'package:devprompt/src/features/welcome/presentation/pages/welcome_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: MyHomePage.pageName,
      builder: (context, state) => MyHomePage(),
    ),
    GoRoute(
      path: WelcomePage.pageName,
      builder: (context, state) => WelcomePage(),
    ),
    GoRoute(
      path: DashboardPage.pageName,
      builder: (context, state) {
        User? user = state.extra as User?;
        return DashboardPage(user: user);
      },
    ),
    GoRoute(
      path: PromptchatPage.pageName,
      builder: (context, state) => PromptchatPage(),
    ),

    GoRoute(
      path: DevPromptSettingsPage.pageName,
      builder: (context, state) {
        User? user = state.extra as User?;
        return DevPromptSettingsPage(user: user);
      },
    ),
  ],
);
