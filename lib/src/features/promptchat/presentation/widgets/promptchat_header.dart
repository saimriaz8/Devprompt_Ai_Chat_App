import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:devprompt/src/features/dashboard/presentation/constants/common_prompts.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PromptchatHeader extends StatelessWidget {
  final double width;
  final double height;
  final List<Map<String, dynamic>> chatHistory;
  const PromptchatHeader({
    super.key,
    required this.height,
    required this.width,
    required this.chatHistory,
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
                    context.read<PromptchatBloc>().add(ResetPromptChatState());
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
                    if (chatHistory.isNotEmpty) {
                      savedChats.add({
                        'title': chatHistory[0]['user'],
                        'subTitle': chatHistory[1]['ai'],
                        'chatHistory': chatHistory,
                      });
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Prompt saved')));
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Chat are empty')));
                    }
                  },
                  icon: const Icon(Icons.bookmark),
                  tooltip: 'Save',
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
