import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/promptchat/presentation/widgets/promptchat_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromptchatPage extends StatefulWidget {
  static const String pageName = '/promptchat';
  const PromptchatPage({super.key});

  @override
  State<PromptchatPage> createState() => _PromptchatPageState();
}

class _PromptchatPageState extends State<PromptchatPage>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late TextEditingController questionController;
  late Animation<Offset> promptHeaderAnimation;
  late Animation<Offset> promptBodyAnimation;

  @override
  void initState() {
    super.initState();
    questionController = TextEditingController();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );
    promptHeaderAnimation = Tween<Offset>(
      begin: Offset(0, -1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.0, 0.5)),
    );
    promptBodyAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: animationController, curve: Interval(0.5, 1.0)),
    );

    animationController.forward(from: 0);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
    questionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PromptchatBloc, PromptchatState>(
          bloc: context.watch<PromptchatBloc>(),
          builder: (context, state) {
            return switch (state) {
              PromptchatInitialState() => PromptchatBody(
                height: height,
                width: width,
                animationController: animationController,
                promptHeaderAnimation: promptHeaderAnimation,
                promptBodyAnimation: promptBodyAnimation,
                chatHistory: [],
                isLoadingState: false,
                questionController: questionController,
              ),
              PromptchatLoadingState(chatHistory : var chatHistory) => PromptchatBody(
                height: height,
                width: width,
                animationController: animationController,
                promptHeaderAnimation: promptHeaderAnimation,
                promptBodyAnimation: promptBodyAnimation,
                chatHistory: chatHistory,
                isLoadingState: true,
                questionController: questionController,
              ),
              PromptchatLoadedState(chatHistory: var chatHistory) =>
                PromptchatBody(
                  height: height,
                  width: width,
                  animationController: animationController,
                  promptHeaderAnimation: promptHeaderAnimation,
                  promptBodyAnimation: promptBodyAnimation,
                  chatHistory: chatHistory,
                  isLoadingState: false,
                  questionController: questionController,
                ),
              PromptchatFailureState(chatHistory: var chatHistory) =>
                PromptchatBody(
                  height: height,
                  width: width,
                  animationController: animationController,
                  promptHeaderAnimation: promptHeaderAnimation,
                  promptBodyAnimation: promptBodyAnimation,
                  chatHistory: chatHistory,
                  isLoadingState: false,
                  questionController: questionController,
                ),
            };
          },
        ),
      ),
    );
  }
}
