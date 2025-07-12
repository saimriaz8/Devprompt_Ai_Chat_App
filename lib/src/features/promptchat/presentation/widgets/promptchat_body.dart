import 'package:devprompt/src/core/theme/app_colors.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/promptchat/presentation/widgets/chat_bubble_widget.dart';
import 'package:devprompt/src/features/promptchat/presentation/widgets/promptchat_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromptchatBody extends StatelessWidget {
  final double width;
  final double height;
  final Animation<Offset> promptHeaderAnimation;
  final Animation<Offset> promptBodyAnimation;
  final AnimationController animationController;
  final List<Map<String, String>> chatHistory;
  final TextEditingController questionController;
  final bool isLoadingState;
  const PromptchatBody({
    super.key,
    required this.height,
    required this.width,
    required this.animationController,
    required this.promptHeaderAnimation,
    required this.promptBodyAnimation,
    required this.chatHistory,
    required this.isLoadingState,
    required this.questionController,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          AnimatedBuilder(
            animation: promptHeaderAnimation,
            builder:
                (context, child) => FadeTransition(
                  opacity: animationController.drive(
                    CurveTween(curve: Interval(0.0, 0.5)),
                  ),
                  child: SlideTransition(
                    position: promptHeaderAnimation,
                    child: child,
                  ),
                ),
            child: PromptchatHeader(height: height, width: width),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: promptBodyAnimation,
              builder:
                  (context, child) => FadeTransition(
                    opacity: animationController.drive(
                      CurveTween(curve: Interval(0.5, 1.0)),
                    ),
                    child: SlideTransition(
                      position: promptBodyAnimation,
                      child: child,
                    ),
                  ),
              child: Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Column(
                  children: [
                    if (chatHistory.isEmpty)
                      Center(
                        child: Text(
                          'Where should we begin',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: chatHistory.length,
                        itemBuilder: (context, index) {
                          final item = chatHistory[index];
                          final isUser = item.containsKey("user");
                          return ChatBubbleWidget(
                            message:
                                item[isUser ? 'user' : 'ai'] ??
                                'Something went wrong',
                            isUser: isUser,
                            height: height,
                            width: width,
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5,),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: questionController,
                              cursorColor:
                                  Theme.of(context).brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                              decoration: InputDecoration(
                                hintText: "Type your question...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed:
                                isLoadingState
                                    ? null
                                    : () {
                                      if (questionController.text
                                          .trim()
                                          .isNotEmpty) {
                                        context.read<PromptchatBloc>().add(
                                          SendPromptEvent(
                                            prompt:
                                                questionController.text.trim(),
                                          ),
                                        );
                                        questionController.clear();
                                      }
                                    },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isLoadingState
                                      ? Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.darkThemeBackgroundColor
                                          : Colors.white
                                      : AppColors.primaryColor,
                              foregroundColor:
                                  Theme.of(context).brightness == Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                            ),
                            child:
                                isLoadingState
                                    ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color:
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? Colors.white
                                                : Colors.black,
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : Icon(Icons.send),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
