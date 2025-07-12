import 'package:flutter/material.dart';

class EmptySavedChatsWidget extends StatelessWidget {
  const EmptySavedChatsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Container(
      width: width * 0.9,
      height: height * 0.22,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orangeAccent.withOpacity(0.4)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Optional: Replace with Lottie.asset() or Image.asset()
          Icon(
            Icons.chat_bubble_outline,
            color: Colors.orangeAccent,
            size: height * 0.06,
          ),
          
          Text(
            "No saved chats yet!",
            style: TextStyle(
              fontSize: height * 0.025,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          
          Text(
            "Start chatting with your AI assistant to save useful conversations.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: height * 0.018,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
