import "package:logger/logger.dart";
import 'package:test_/models/query/rag_model.dart';
import 'package:test_/repository/query/rag_repository.dart';

class QueryProcessingService {
  final Logger _logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 3,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  ));
  final RAGRepository _rag = RAGRepository();

  Future<RAGModel> uploadToPinecone(
      String translatedText, String fileName) async {
    if (translatedText.isEmpty) {
      _logger.e("Translated text is empty. Skipping upload to Pinecone.");
      throw Exception("Translated text is empty");
    }
    try {
      RAGModel indexResponse =
          await _rag.indexTextIntoPinecone(translatedText, fileName);
      _logger.i("Index Upload Response: ${indexResponse.toJson()}");
      return indexResponse;
    } catch (e) {
      _logger.e("Failed to upload to Pinecone: $e");
      rethrow;
    }
  }
}
