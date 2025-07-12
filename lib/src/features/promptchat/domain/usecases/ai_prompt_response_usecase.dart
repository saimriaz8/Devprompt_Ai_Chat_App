import 'package:devprompt/src/features/promptchat/domain/repositories/abstract_ai_prompt_repository.dart';

class AiPromptResponseUsecase {
  final AiPromptRepository _aiPromptRepository;
  AiPromptResponseUsecase(this._aiPromptRepository);
  Future<String> call(String prompt) async {
    return _aiPromptRepository.getAiPromptResponse(prompt);
  }
}
