import 'package:flutter/material.dart';

class StartChatButton extends StatelessWidget {
  final VoidCallback onTap;

  const StartChatButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width * 0.9,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.06,
          vertical: height * 0.025,
        ),
        margin: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          gradient:
              isDark
                  ? LinearGradient(
                    colors: [Color(0xFFF4F4F4), Color(0xFFE0E0E0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : const LinearGradient(
                    colors: [Color(0xFF242424), Color(0xFF101010)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(4, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Icon(
              Icons.chat_bubble_outline,
              color: isDark ? Colors.black : Colors.white,
              size: 24,
            ),
            const SizedBox(width: 10),
             Text(
              'Start a new AI chat',
              style: TextStyle(
                color: isDark ? Colors.black : Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
