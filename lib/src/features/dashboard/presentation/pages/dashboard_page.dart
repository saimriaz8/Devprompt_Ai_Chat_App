import 'package:devprompt/src/features/dashboard/presentation/constants/common_prompts.dart';
import 'package:devprompt/src/features/dashboard/presentation/widgets/common_prompt_card.dart';
import 'package:devprompt/src/features/dashboard/presentation/widgets/dashboard_appbar.dart';
import 'package:devprompt/src/features/dashboard/presentation/widgets/empty_saved_chat_widget.dart';
import 'package:devprompt/src/features/dashboard/presentation/widgets/start_chat_widget.dart';
import 'package:devprompt/src/features/promptchat/presentation/bloc/promptchat_bloc.dart';
import 'package:devprompt/src/features/promptchat/presentation/pages/promptchat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardPage extends StatefulWidget {
  static const String pageName = '/dashboard';
  final User? user;
  const DashboardPage({super.key, required this.user});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> appBarSlideAnimation;
  late Animation<Offset> startChatWidgetSlideAnimation;
  late Animation<Offset> savedChatWidgetSlideAnimation;
  late Animation<Offset> commonPromptWidgetSlideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1600),
    );

    appBarSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.0, 0.25)),
    );
    startChatWidgetSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.25, 0.5)),
    );
    savedChatWidgetSlideAnimation = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.5, 0.75)),
    );
    commonPromptWidgetSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Interval(0.75, 1.0)),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0);
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //App bar widget
              AnimatedBuilder(
                animation: appBarSlideAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: _animationController.drive(
                        CurveTween(curve: Interval(0.0, 0.25)),
                      ),
                      child: SlideTransition(
                        position: appBarSlideAnimation,
                        child: child,
                      ),
                    ),
                child: DashboardAppbar(
                  height: height,
                  width: width,
                  user: widget.user,
                ),
              ),

              // Start ai chat widget
              AnimatedBuilder(
                animation: startChatWidgetSlideAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: _animationController.drive(
                        CurveTween(curve: Interval(0.25, 0.5)),
                      ),
                      child: SlideTransition(
                        position: startChatWidgetSlideAnimation,
                        child: child,
                      ),
                    ),
                child: StartChatButton(
                  onTap:
                      () => GoRouter.of(context).push(PromptchatPage.pageName),
                ),
              ),

              // Saved chat widget
              AnimatedBuilder(
                animation: savedChatWidgetSlideAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: _animationController.drive(
                        CurveTween(curve: Interval(0.5, 0.75)),
                      ),
                      child: SlideTransition(
                        position: savedChatWidgetSlideAnimation,
                        child: child,
                      ),
                    ),
                child: SizedBox(
                  width: width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.9,
                        child: Text(
                          'Saved chats',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ), // SavedChatTile(   title: 'Hello', subtitle: 'Here i am')
                      EmptySavedChatsWidget(),
                    ],
                  ),
                ),
              ),

              // Common prompt widget
              AnimatedBuilder(
                animation: commonPromptWidgetSlideAnimation,
                builder:
                    (context, child) => FadeTransition(
                      opacity: _animationController.drive(
                        CurveTween(curve: Interval(0.75, 1.0)),
                      ),
                      child: SlideTransition(
                        position: commonPromptWidgetSlideAnimation,
                        child: child,
                      ),
                    ),
                child: SizedBox(
                  width: width * 0.9,
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.9,
                        child: Text(
                          'Common Prompts',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.9,
                        height: height * 0.35,
                        child: ListView.separated(
                          itemCount: commonPrompts.length,
                          itemBuilder: (context, index) {
                            final prompt = commonPrompts[index];
                            return CommonPromptCard(
                              title: prompt['title'] ?? 'Title not fount',
                              description:
                                  prompt['desc'] ?? 'Description not found',
                              onTap: () {
                                GoRouter.of(
                                  context,
                                ).push(PromptchatPage.pageName);
                                context.read<PromptchatBloc>().add(
                                  SendPromptEvent(
                                    prompt:
                                        prompt['title'] ??
                                        'Something went wrong',
                                  ),
                                );
                              },
                            );
                          },
                          separatorBuilder:
                              (context, index) => SizedBox(height: 5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
