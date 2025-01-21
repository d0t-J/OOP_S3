import 'package:logging/logging.dart';
import 'package:test_/models/translation/translation_model.dart';
import 'package:test_/repository/translation/translation_repository.dart';

class TranslationService {
  final Logger _logger = Logger("Translation Helper");
  final TranslationRepository _translator = TranslationRepository();

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      _logger.info("Extracted Text: $text");
      TranslationResult result =
          await _translator.translate(text, targetLanguage);
      String translatedText = result.translatedText;
      _logger.info("Translated Text: $translatedText");
      return translatedText;
    } catch (e) {
      _logger.severe("Error occurred while translating: $e");
      rethrow;
    }
  }
}
