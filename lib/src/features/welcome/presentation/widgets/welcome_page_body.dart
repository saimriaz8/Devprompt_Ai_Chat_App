import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:devprompt/src/features/welcome/presentation/widgets/sign_in_google_button_widget.dart';
import 'package:devprompt/src/features/welcome/presentation/widgets/sign_in_option_widget.dart';
import 'package:devprompt/src/features/welcome/presentation/widgets/user_prompt_card.dart';
import 'package:flutter/material.dart';

class WelcomePageBody extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoadingState;
  const WelcomePageBody({super.key, required this.height, required this.width, required this.isLoadingState});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: width * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "DevPrompt",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold,),
                ),
                Text(
                  "Your AI Pair Programmer",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: width, height: 10),
                Text(
                  "Discuss code, get suggestions, and learn faster with AI.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.9,
            height: height * 0.3,
            child: Stack(
              children: [
                Positioned(
                  top: 80,
                  right: 5,
                  left: 5,
                  child: SizedBox(
                    height: height * 0.1,
                    child: Transform.rotate(
                      angle: 0.1,
                      child: UserPromptCard(
                        imageUrl: 'assets/images/person 2.png',
                        name: 'Eric Solomon',
                        prompt: 'Your image search is served',
                        color: AppColors.greenColor,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: height * 0.1,
                    child: UserPromptCard(
                      imageUrl: 'assets/images/person 1.png',
                      name: 'Kaiya Koorsgaard',
                      prompt: 'Hi, people!',
                      color: AppColors.pinkColor,
                      height: height,
                      width: width,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: height * 0.1,
                    child: Transform.rotate(
                      angle: -0.05,
                      child: UserPromptCard(
                        imageUrl: 'assets/images/person 3.png',
                        name: 'Lana Rodkevych',
                        prompt: 'Saved prompt for dribble',
                        color: AppColors.indigoColor,
                        height: height,
                        width: width,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: width * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SignInOptionWidget(
                  imagePath:
                      Theme.of(context).brightness == Brightness.dark
                          ? 'assets/images/apple_white.png'
                          : 'assets/images/apple_black.png',
                ),
                SizedBox(width: 10),
                SignInOptionWidget(imagePath: 'assets/images/facebook.png'),
              ],
            ),
          ),
          SignInGoogleButtonWidget(height: height, width: width, isLoadingState: isLoadingState,),
        ],
      ),
    );
  }
}
