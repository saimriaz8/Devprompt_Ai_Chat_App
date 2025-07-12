part of 'promptchat_bloc.dart';

@immutable
sealed class PromptchatState {
  const PromptchatState();
}

@immutable
class PromptchatInitialState extends PromptchatState {}

@immutable
class PromptchatLoadingState extends PromptchatState {
  final List<Map<String, String>> chatHistory;
  const PromptchatLoadingState(this.chatHistory);
}

@immutable
class PromptchatLoadedState extends PromptchatState {
  final List<Map<String, String>> chatHistory;
  const PromptchatLoadedState(this.chatHistory);
}

@immutable
class PromptchatFailureState extends PromptchatState {
  final List<Map<String, String>> chatHistory;
  const PromptchatFailureState(this.chatHistory);
}
