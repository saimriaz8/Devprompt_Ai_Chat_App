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

class DevPromptSettingsPage extends StatelessWidget {
  final User? user;
  static const String pageName = '/settingpage';
  const DevPromptSettingsPage({super.key, required this.user});

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
              Row(
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
                        user?.displayName ?? 'No user found',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user?.email ?? 'No email found',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: height * 0.04),

              const Text(
                "Preferences",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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

              SizedBox(height: height * 0.03),

              const Text(
                "More",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
                onTap: () async {
                  await signOutUserUsecase();
                  // ignore: use_build_context_synchronously
                  context.read<WelcomeBloc>().add(ResetStateEvent());
                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).go(MyHomePage.pageName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
