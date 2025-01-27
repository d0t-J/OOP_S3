import 'package:logger/logger.dart';
import "package:test_/utils/log/logger_util.dart";
import "package:test_/models/query/rag_model.dart";
import "package:test_/api/query/rag.dart";

class RAGRepository {
  final RAG rag = RAG();
  final Logger _logger = LoggerUtil.createLogger();

  Future<RAGModel> indexTextIntoPinecone(String text, String file_name) async {
    try {
      final Map<String, dynamic> data =
          await rag.indexTextIntoPinecone(text, file_name);
      _logger.i('rag_repository.dart:\nResponse Body: $data');
      return RAGModel.fromJson(data);
    } catch (e) {
      _logger.e("rag_repository.dart:\nFailed to Index text. Error: $e");
      throw Exception('Failed to index text. Error: $e');
    }
  }

  Future<RAGModel> sendUserQuery(String query, String file_name) async {
    try {
      final Map<String, dynamic> data =
          await rag.sendUserQuery(query, file_name);
      _logger.i('rag_repository.dart:\nResponse Body: $data');
      return RAGModel.fromJson(data);
    } catch (e) {
      _logger.e("rag_repository.dart:\nFailed to send user query. Error: $e");
      throw Exception('Failed to send user query. Error: $e');
    }
  }
}
