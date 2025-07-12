import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ChatBubbleWidget extends StatelessWidget {
  final String message;
  final bool isUser;
  final double width;
  final double height;
  const ChatBubbleWidget({
    super.key,
    required this.message,
    required this.isUser,
    required this.height,
    required this.width
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color:
              isUser
                  ? AppColors.primaryColor
                  : isDark
                  ? Colors.white
                  : AppColors.darkThemeBackgroundColor,
          borderRadius: BorderRadius.circular(12),
        ),
        constraints: BoxConstraints(maxWidth: width * 0.75),
        child: Text(
          message,
          style: TextStyle(
            color: isDark ? Colors.black : Colors.white,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
