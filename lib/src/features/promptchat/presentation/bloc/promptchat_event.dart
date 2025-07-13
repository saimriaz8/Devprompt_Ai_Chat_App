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

@immutable
class SavedChatEvent extends PromptchatEvent {
  final List<Map<String, String>> chatHistory;
  const SavedChatEvent({required this.chatHistory});
}

@immutable
class ResetPromptChatState extends PromptchatEvent {
}