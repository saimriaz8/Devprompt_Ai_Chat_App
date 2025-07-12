part of 'promptchat_bloc.dart';

@immutable
abstract class PromptchatEvent {
  const PromptchatEvent();
}

@immutable
class SendPromptEvent extends PromptchatEvent {
  final String prompt;
  const SendPromptEvent({required this.prompt});
}