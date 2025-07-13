import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AiPromptRemoteDatasource {
  Future<String> askMestralAi(String prompt);
}

class AiPromptRemoteDatasourceImplementation extends AiPromptRemoteDatasource {
  final Dio dio;
  AiPromptRemoteDatasourceImplementation(this.dio);

  @override
  Future<String> askMestralAi(String prompt) async {
  const String baseUrl = 'https://openrouter.ai/api/v1/chat/completions';
  final apiKey = dotenv.env['OPEN_ROUTER_API_KEY'];

  try {
    final response = await dio.post(
      baseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'HTTP-Referer': 'https://devprompt.flutter', // must be a valid URL format
          'X-Title': 'Devprompt AI Chat',
        },
      ),
      data: {
        "model": "mistralai/mixtral-8x7b-instruct",
        "messages": [
          {
            "role": "system",
            "content": "You are a helpful AI assistant that writes clean code and explains it well.",
          },
          {
            "role": "user",
            "content": prompt,
          }
        ],
        "max_tokens": 512,
        "temperature": 0.2,
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
    if (e is DioError) {
      print("Dio error response: ${e.response?.data}");
      return e.response?.data.toString() ?? "Unknown Dio error";
    }
    return e.toString();
  }
}

}
