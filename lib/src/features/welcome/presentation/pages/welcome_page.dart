import 'package:devprompt/src/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/widgets/welcome_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return SafeArea(
      child: Scaffold(
        body: BlocListener<WelcomeBloc, WelcomeState>(
          listenWhen: (previous, current) => current is WelcomeSuccessState,
          listener: (context, state) {
            if (state is WelcomeSuccessState) {
              GoRouter.of(
                context,
              ).push(DashboardPage.pageName, extra: state.user);
            }
          },
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            bloc: context.watch<WelcomeBloc>(),
            builder: (context, state) {
              return switch (state) {
                WelcomeInitialState() => WelcomePageBody(
                  height: height,
                  width: width,
                  isLoadingState: false,
                ),
                WelcomeLoadingState() => WelcomePageBody(
                  height: height,
                  width: width,
                  isLoadingState: true,
                ),
                WelcomeSuccessState(user: _) => Center(
                  child: SizedBox(),
                ),
                WelcomeFailureState(message: var message) => Center(
                  child: Text(message.toString()),
                ),
              };
            },
          ),
        ),
      ),
    );
  }
}
