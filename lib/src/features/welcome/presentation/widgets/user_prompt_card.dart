import 'package:flutter/material.dart';

class UserPromptCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String prompt;
  final Color color;
  final double width;
  final double height;

  const UserPromptCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.prompt,
    required this.color,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.85, // 85% of parent width
      height: height * 0.1, // 10% of screen height
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.015,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(20))
      ),
      child: Row(
        children: [
          //Optional Image (Uncomment if using image)
    
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              imageUrl,
              height: height * 0.06,
              width: height * 0.06,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          
          // If no image, keep space for alignment
         

          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: height * 0.02,
                  ),
                ),
                SizedBox(height: height * 0.005),
                Text(
                  prompt,
                  style: TextStyle(
                    fontSize: height * 0.017,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
