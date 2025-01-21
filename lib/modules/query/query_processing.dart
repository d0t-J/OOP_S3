import "package:logging/logging.dart";
import 'package:test_/models/query/rag_model.dart';
import 'package:test_/repository/query/rag_repository.dart';

class QueryProcessingService {
  final Logger _logger = Logger("Rag Helper Functions");
  final RAGRepository _rag = RAGRepository();

  Future<RAGModel> uploadToPinecone(
      String translatedText, String fileName) async {
    if (translatedText.isEmpty) {
      _logger.warning("Translated text is empty. Skipping upload to Pinecone.");
      throw Exception("Translated text is empty");
    }
    try {
      RAGModel indexResponse =
          await _rag.indexTextIntoPinecone(translatedText, fileName);
      _logger.info("Index Upload Response: ${indexResponse.toJson()}");
      return indexResponse;
    } catch (e) {
      _logger.warning("Failed to upload to Pinecone: $e");
      rethrow;
    }
  }
}
