part of 'welcome_bloc.dart';

@immutable
abstract class WelcomeEvent {}

@immutable
class SignInWithGoogleEvent extends WelcomeEvent {}
