import 'package:devprompt/src/features/settings/presentation/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:go_router/go_router.dart';

class DashboardAppbar extends StatelessWidget {
  final double width;
  final double height;
  final User? user;

  const DashboardAppbar({
    super.key,
    required this.width,
    required this.height,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: width * 0.95,
      height: height * 0.1,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:
                isDark
                    ? Colors.black.withOpacity(0.3)
                    : Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 👤 User Greeting & Status
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${user?.displayName ?? 'Developer'} 👋",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Active now',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? Colors.white70 : Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ],
          ),

          /// ⚙️ Settings Icon with AI/dev style
          IconButton(
            onPressed: () {
              GoRouter.of(context).push(DevPromptSettingsPage.pageName, extra: user);
            },
            icon: const Icon(Icons.settings_suggest_outlined),
            tooltip: 'Settings',
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                isDark ? Colors.grey[900] : Colors.grey[200],
              ),
              foregroundColor: WidgetStatePropertyAll(
                isDark ? Colors.white : Colors.black,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
            ),
          ),
        ],
      ),
    );
  }
}
