import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/shared/widgets/circular_progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInGoogleButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final bool isLoadingState;
  const SignInGoogleButtonWidget({
    super.key,
    required this.height,
    required this.width,
    required this.isLoadingState,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.8,
      height: 50,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
          foregroundColor: WidgetStatePropertyAll(
            Theme.of(context).brightness == Brightness.light
                ? Colors.black
                : Colors.white,
          ),
        ),
        onPressed: () => context.read<WelcomeBloc>().add(SignInWithGoogleEvent()),
        child:
            isLoadingState
                ? CircularProgressIndicatorWidget()
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in with google',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.google),
                  ],
                ),
      ),
    );
  }
}
