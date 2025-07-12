import 'package:flutter/material.dart';

class SavedChatTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isOnline;

  const SavedChatTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final tileWidth = screenWidth * 0.42;
    final tileHeight = screenHeight * 0.22;

    return Container(
      width: tileWidth,
      height: tileHeight,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.amber[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.shade700, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(2, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ─── Top Row: Circle + Online dot + Icon
          Row(
            children: [
              CircleAvatar(
                radius: tileWidth * 0.08,
                backgroundColor: Colors.black,
                child: Text(
                  title.isNotEmpty ? title[0].toUpperCase() : '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: tileWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              if (isOnline)
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              const Spacer(),
              Icon(
                Icons.code_rounded,
                color: Colors.deepOrange,
                size: tileWidth * 0.08,
              ),
            ],
          ),
          const Spacer(),
          /// ─── Title
          Text(
            title,
            style: TextStyle(
              fontSize: tileWidth * 0.09,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          /// ─── Subtitle
          Text(
            subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: tileWidth * 0.07,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
