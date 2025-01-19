import 'package:test_/api/translation/translation_service.dart';
import 'package:test_/models/translation/translation_model.dart';
// import 'package:test_/modules/translation/translation_service_mock.dart';

class TranslationRepository {
  final TranslationService _service = TranslationService();

  Future<TranslationResult> translate(String text, String targetLanguage) async {
    String translatedText = await _service.translateText(text, targetLanguage);
    return TranslationResult(
        originalText: text, translatedText: translatedText);
  }
}

//! Mock Translation Service
// class TranslationRepository {
//   final bool useMock;
//   late final TranslationService _service;
//   TranslationRepository({this.useMock = false}) {
//     _service = useMock ? MockTranslationService() : TranslationService();
//   }

//   Future<TranslationResult> translate(
//       String text, String targetLanguage) async {
//     String translatedText = await _service.translateText(text, targetLanguage);
//     return TranslationResult(
//         originalText: text, translatedText: translatedText);
//   }
// }
