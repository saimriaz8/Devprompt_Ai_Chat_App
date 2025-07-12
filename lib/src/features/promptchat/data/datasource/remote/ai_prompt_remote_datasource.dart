import 'package:dio/dio.dart';

abstract class AiPromptRemoteDatasource {
  Future<String> askMestralAi(String prompt);
}

class AiPromptRemoteDatasourceImplementation extends AiPromptRemoteDatasource {
  final Dio dio;
  AiPromptRemoteDatasourceImplementation(this.dio);

  @override
  Future<String> askMestralAi(String prompt) async {
    const String baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
    const String apiKey =
        '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';
    try {
      final response = await dio.post(
        baseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
            'Content-Type': 'application/json',
            'HTTP-Referer': 'https://devprompt.flutter',
            'X-Title': 'Devprompt AI Chat',
          },
        ),
        data: {
          "model": "mistralai/mistral-7b-instruct",
          "messages": [
            {
              "role": "system",
              "content":
                  "You are a helpful and knowledgeable AI assistant strictly specialized in software development, computer science, and related technical fields. You assist with programming, frameworks, debugging, algorithms, system design, dev tools, and other developer-related queries. Politely decline to answer questions outside of this scope, such as topics related to health, finance, politics, or personal matters.",
            },
            {"role": "user", "content": prompt},
          ],
          "max_tokens": 200,
        },
      );

      final data = response.data;

      if (data != null &&
          data['choices'] != null &&
          data['choices'].toString().isNotEmpty) {
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        return 'Something went wrong';
      }
    } catch (e) {
      return e.toString();
    }
  }
}
