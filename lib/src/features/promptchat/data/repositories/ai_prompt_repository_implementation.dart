import 'package:devprompt/src/features/promptchat/data/datasource/remote/ai_prompt_remote_datasource.dart';
import 'package:devprompt/src/features/promptchat/domain/repositories/abstract_ai_prompt_repository.dart';

class AiPromptRepositoryImplementation extends AiPromptRepository {
  AiPromptRemoteDatasource aiPromptRemoteDatasource;

  AiPromptRepositoryImplementation(this.aiPromptRemoteDatasource);

  @override
  Future<String> getAiPromptResponse(String prompt) async {
    return aiPromptRemoteDatasource.askMestralAi(prompt);
  }
}
