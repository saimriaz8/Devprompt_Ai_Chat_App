import 'package:devprompt/src/features/welcome/presentation/boc/welcome_bloc.dart';
import 'package:devprompt/src/features/welcome/presentation/widgets/welcome_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Size(:width, :height) = size;
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<WelcomeBloc, WelcomeState>(
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
              WelcomeSuccessState(user: var user) => Center(
                child: Text(user?.displayName ?? 'John'),
              ),
              WelcomeFailureState(message: var message) => Center(
                child: Text(message.toString()),
              ),
            };
          },
        ),
      ),
    );
  }
}
