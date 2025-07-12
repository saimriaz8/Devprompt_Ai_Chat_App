import 'package:flutter/material.dart';

class CommonPromptCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const CommonPromptCard({
    super.key,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width * 0.9,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(2, 3),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.lightbulb_outline, color: Colors.orangeAccent, size: 24),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: size.height * 0.022,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(
                fontSize: size.height * 0.017,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
