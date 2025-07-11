import 'package:flutter/material.dart';

class SignInOptionWidget extends StatelessWidget {
  final String imagePath;
  const SignInOptionWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      width: 40, // total size (outer circle)
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          strokeAlign: 1,
          color:
              Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white, // stroke color
          width: 1, // stroke width
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        radius: 20, // slightly smaller than outer container
        backgroundImage: AssetImage(imagePath),
      ),
    );
  }
}
