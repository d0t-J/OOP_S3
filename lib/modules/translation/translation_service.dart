import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import '../../utils/api_constants.dart';

class TranslationService {
  final String apiKey = ApiConstants.azureTranslateApiKey;
  final String endpoint =
      "https://api.cognitive.microsofttranslator.com/translate?api-version=3.0";
  final String region = ApiConstants.azureRegion;

  final Logger _logger = Logger('TranslationService');

  Future<String> translateText(String text, String targetLanguage) async {
    final url = Uri.parse('$endpoint&to=$targetLanguage&textType=plain');
    final Headers = {
      'Content-Type': 'application/json',
      'Ocp-Apim-Subscription-Key': apiKey,
      'Ocp-Apim-Subscription-Region': region,
    };
    final Body = jsonEncode([
      {
        "Text": text,
      }
    ]);

    //? Debug: Log the request details
    _logger.info('Request URL: $url');
    _logger.info('Request Headers: $Headers');
    _logger.info('Request Body: $Body');

    final response = await http.post(url, headers: Headers, body: Body);

    _logger.info('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data[0]['translations'][0]['text'];
    } else {
      throw Exception(
          'Failed to translate text. Error Code: ${response.statusCode}');
    }
  }
}
