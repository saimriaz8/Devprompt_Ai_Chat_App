import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PromptchatHeader extends StatelessWidget {
  final double width;
  final double height;
  const PromptchatHeader({
    super.key,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height * 0.2,
      decoration: BoxDecoration(
        color: isDark ? Colors.white : AppColors.darkThemeBackgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Appbar like widget
          SizedBox(
            width: width * 0.9,
            height: height * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(Duration(milliseconds: 600));
                    // ignore: use_build_context_synchronously
                    GoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.keyboard_double_arrow_left),
                  tooltip: 'Back',
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      isDark ? Colors.grey[900] : Colors.grey[200],
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      isDark ? Colors.white : Colors.black,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // Navigate to settings page or show bottom sheet
                  },
                  icon: const Icon(Icons.edit_note),
                  tooltip: 'Edit Note',
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      AppColors.primaryColor,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      isDark ? Colors.white : Colors.black,
                    ),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    padding: WidgetStatePropertyAll(EdgeInsets.all(10)),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(
            width: width * 0.9,
            child: Text(
              'DevPrompt – Your AI Powered Developer Companion',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
