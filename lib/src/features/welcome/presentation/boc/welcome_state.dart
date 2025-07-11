part of 'welcome_bloc.dart';

@immutable
sealed class WelcomeState {
  const WelcomeState();
}

@immutable
class WelcomeInitialState extends WelcomeState {}

@immutable
class WelcomeLoadingState extends WelcomeState {}

@immutable
class WelcomeSuccessState extends WelcomeState {
  final User? user;
  const WelcomeSuccessState(this.user);
}

@immutable
class WelcomeFailureState extends WelcomeState {
  final String message;
  const WelcomeFailureState(this.message);
}
