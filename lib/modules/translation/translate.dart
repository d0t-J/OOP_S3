import 'package:logger/logger.dart';
import 'package:test_/utils/log/logger_util.dart';
import 'package:test_/models/translation/translation_model.dart';
import 'package:test_/repository/translation/translation_repository.dart';

class TranslationService {
  final Logger _logger = LoggerUtil.createLogger();
  final TranslationRepository _translator = TranslationRepository();

  Future<String> translateText(String text, String targetLanguage) async {
    try {
      _logger.i("translate.dart\nExtracted Text: $text");
      TranslationResult result =
          await _translator.translate(text, targetLanguage);
      String translatedText = result.translatedText;
      _logger.i("translate.dart\nTranslated Text: $translatedText");
      return translatedText;
    } catch (e) {
      _logger.e("translate.dart\nError occurred while translating: $e");
      rethrow;
    }
  }
}
