import 'package:logger/logger.dart';
import "package:test_/utils/log/logger_util.dart";
import 'package:test_/models/query/rag_model.dart';
import 'package:test_/repository/query/rag_repository.dart';

class QueryProcessingService {
  final Logger _logger = LoggerUtil.createLogger();
  final RAGRepository _rag = RAGRepository();

  Future<RAGModel> uploadToPinecone(
      String translatedText, String fileName) async {
    if (translatedText.isEmpty) {
      _logger.e(
          "query_processing.dart:\nTranslated text is empty. Skipping upload to Pinecone.");
      throw Exception("Translated text is empty");
    }
    try {
      RAGModel indexResponse =
          await _rag.indexTextIntoPinecone(translatedText, fileName);
      _logger.i(
          "query_processing.dart:\nIndex Upload Response: ${indexResponse.toJson()}");
      return indexResponse;
    } catch (e) {
      _logger.e("query_processing.dart:\nFailed to upload to Pinecone: $e");
      rethrow;
    }
  }

  Future<String> sendUserMessage(String query, String filename) async {
    if (query.isEmpty) {
      _logger.e("query_processing.dart:\nQuery is empty. Message not sent.");
      throw Exception("Query is empty");
    }

    try {
      RAGModel messageResponse = await _rag.sendUserQuery(query, filename);
      _logger.i(
          "query_processing.dart:\nMessage Response: ${messageResponse.toJson()}");
      return messageResponse.response ?? "No response from server";
    } catch (e) {
      _logger.e("query_processing.dart:\nFailed to send user message $e");
      rethrow;
    }
  }
}
