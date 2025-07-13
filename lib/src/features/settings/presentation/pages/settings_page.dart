import 'package:devprompt/main.dart';
import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:devprompt/src/features/settings/auth/domain/settings_auth_usecase.dart';
import 'package:devprompt/src/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/features/welcome/welcome_injection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DevPromptSettingsPage extends StatefulWidget {
  final User? user;
  static const String pageName = '/settingpage';
  const DevPromptSettingsPage({super.key, required this.user});

  @override
  State<DevPromptSettingsPage> createState() => _DevPromptSettingsPageState();
}

class _DevPromptSettingsPageState extends State<DevPromptSettingsPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> profileAnimation;
  late Animation<Offset> preferencesAnimation;
  late Animation<Offset> moreAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1100),
    );

    profileAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.33)),
    );
    preferencesAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.33, 0.66)),
    );
    moreAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.66, 1.0)),
    );
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final signOutUserUsecase = sl<SignOutUserUsecase>();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var size = MediaQuery.sizeOf(context);
    var Size(:width, :height) = size;
    height -= kToolbarHeight;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: isDark ? Colors.white : Colors.black,
          title: Text("Settings"),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.03),

              // 👤 Profile Section
              AnimatedBuilder(
                animation: profileAnimation,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: animationController.drive(
                      CurveTween(curve: Interval(0.0, 0.33)),
                    ),
                    child: SlideTransition(
                      position: profileAnimation,
                      child: child,
                    ),
                  );
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: width * 0.08,
                      backgroundColor: AppColors.primaryColor,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(width: width * 0.04),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user?.displayName ?? 'No user found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.user?.email ?? 'No email found',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.04),

              AnimatedBuilder(
                animation: preferencesAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: animationController.drive(
                        CurveTween(curve: Interval(0.33, 0.66)),
                      ),
                      child: SlideTransition(
                        position: preferencesAnimation,
                        child: child,
                      ),
                    ),
                child: SizedBox(
                  child: Column(
                    children: [
                      const Text(
                        "Preferences",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: height * 0.015),

                      // 🌗 Theme Toggle (mock)
                      BlocBuilder<SettingsBloc, SettingsState>(
                        bloc: context.watch<SettingsBloc>(),
                        builder: (context, state) {
                          return switch (state) {
                            SettingsLightModeState() => ListTile(
                              leading: const Icon(Icons.brightness_6),
                              title: const Text("Dark Mode"),
                              trailing: Switch(
                                activeColor: AppColors.primaryColor,
                                value: false,
                                onChanged: (_) {
                                  context.read<SettingsBloc>().add(
                                    SwitchToDarkModeEvent(),
                                  );
                                },
                              ),
                            ),
                            SettingsDarkModeState() => ListTile(
                              leading: const Icon(Icons.dark_mode),
                              title: const Text("Light Mode"),
                              trailing: Switch(
                                activeColor: AppColors.primaryColor,
                                value: true,
                                onChanged: (_) {
                                  context.read<SettingsBloc>().add(
                                    SwitchToLightModeEvent(),
                                  );
                                },
                              ),
                            ),
                          };
                        },
                      ),

                      // 🔔 Notifications
                      ListTile(
                        leading: const Icon(Icons.notifications_none),
                        title: const Text("Notifications"),
                        trailing: Switch(
                          activeColor: AppColors.primaryColor,
                          value: true,
                          onChanged: (val) {
                            // TODO: handle notification setting
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: height * 0.03),

              AnimatedBuilder(
                animation: moreAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: animationController.drive(
                        CurveTween(curve: Interval(0.66, 1.0)),
                      ),
                      child: SlideTransition(
                        position: moreAnimation,
                        child: child,
                      ),
                    ),
                child: SizedBox(
                  child: Column(
                    children: [
                      const Text(
                        "More",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(height: height * 0.015),

                      // ℹ️ About
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: const Text("About DevPrompt"),
                        onTap: () {
                          // Show about dialog or navigate
                        },
                      ),

                      // 🚪 Logout
                      ListTile(
                        leading: const Icon(Icons.logout),
                        title: const Text("Logout"),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                title: Row(
                                  children: [
                                    Icon(Icons.logout, color: Colors.red),
                                    SizedBox(width: 10),
                                    Text(
                                      "Logging out?",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                content: Text(
                                  "Are you sure you want to log out? Your session will end.",
                                ),
                                actions: [
                                  TextButton(
                                    style: ButtonStyle(
                                      foregroundColor: WidgetStatePropertyAll(
                                        isDark ? Colors.white : Colors.black,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.of(
                                        dialogContext,
                                      ).pop(); // Close the dialog
                                    },
                                    child: Text("Cancel"),
                                  ),
                                  ElevatedButton.icon(
                                    icon: Icon(Icons.exit_to_app),
                                    label: Text("Log Out"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryColor,
                                      foregroundColor:
                                          isDark ? Colors.white : Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Navigator.of(dialogContext).pop();
                                      await signOutUserUsecase();
                                      // ignore: use_build_context_synchronously
                                      context.read<WelcomeBloc>().add(
                                        ResetStateEvent(),
                                      );
                                      // ignore: use_build_context_synchronously
                                      GoRouter.of(
                                        context,
                                      ).go(MyHomePage.pageName);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
