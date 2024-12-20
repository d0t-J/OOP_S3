import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../api_constants.dart';

class TranslationService {
  final String apiKey = ApiConstants.azureTranslateApiKey;
  final String endpoint =
      "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0";
  // "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0&to=en&from=ur";
  final String region = ApiConstants.azureRegion;

  Future<String> translateText(String text, String targetLanguage) async {
    final url = Uri.parse('$endpoint&to=$targetLanguage');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Ocp-Apim-Subscription-Key': apiKey,
        'Ocp-Apim-Subscription-Region': region,
      },
      body: jsonEncode([
        {'Text': text}
      ]),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['translations'][0]['text'];
    } else {
      throw Exception(
          'Failed to translate text. Error Code: ${response.statusCode}');
    }
  }
}
