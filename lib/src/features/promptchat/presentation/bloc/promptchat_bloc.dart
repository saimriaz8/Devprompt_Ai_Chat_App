import 'package:bloc/bloc.dart';
import 'package:devprompt/src/features/promptchat/domain/usecases/ai_prompt_response_usecase.dart';
import 'package:meta/meta.dart';

part 'promptchat_event.dart';
part 'promptchat_state.dart';

class PromptchatBloc extends Bloc<PromptchatEvent, PromptchatState> {
  final AiPromptResponseUsecase aiPromptResponseUsecase;
  List<Map<String, String>> _chatHistory = [];
  PromptchatBloc(this.aiPromptResponseUsecase)
    : super(PromptchatInitialState()) {
    on<SendPromptEvent>((event, emit) async {
      _chatHistory.add({'user': event.prompt});
      emit(PromptchatLoadingState(List.from(_chatHistory)));
      try {
        String response = await aiPromptResponseUsecase(event.prompt);
        _chatHistory.add({'ai': response});
        emit(PromptchatLoadedState(List.from(_chatHistory)));
      } catch (e) {
        _chatHistory.add({'ai': e.toString()});
        emit(PromptchatFailureState(List.from(_chatHistory)));
      }
    });

    on<SavedChatEvent>((event, emit) async {
      emit(PromptchatLoadedState(event.chatHistory));
    });

    on<ResetPromptChatState>((event, emit) async {
      _chatHistory = [];
      emit(PromptchatInitialState());
    });
  }
}
