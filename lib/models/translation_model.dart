class TranslationResult {
  final String originalText;
  final String translatedText;

  TranslationResult({required this.originalText, required this.translatedText});

  factory TranslationResult.fromJson(Map<String, dynamic> json) {
    return TranslationResult(
      originalText: json['originalText'],
      translatedText: json['translatedText'],
    );
  }
}

//! This class is used to create an object containing the data for the original text and translation text.
