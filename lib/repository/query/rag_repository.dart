import 'package:logging/logging.dart';
import "package:test_/models/query/rag_model.dart";
import "package:test_/api/query/RAG.dart";


class RAGRepository {
  final RAG rag = RAG();
  final Logger _logger = Logger('RagRepository');

  Future<RAGModel> indexTextIntoPinecone(String text, String file_name) async {
    try {
      final Map<String, dynamic> data = await rag.indexTextIntoPinecone(text, file_name);
      _logger.info('Response Body: $data');
      return RAGModel.fromJson(data);
    } catch (e) {
      _logger.warning("Failed to Index text. Error: $e");
      throw Exception('Failed to index text. Error: $e');
    }
  }

  Future<RAGModel> sendUserQuery(String query, String file_name) async {
    try {
      final Map<String, dynamic> data = await rag.sendUserQuery(query, file_name);
      _logger.info('Response Body: $data');
      return RAGModel.fromJson(data);
    } catch (e) {
      _logger.warning("Failed to send user query. Error: $e");
      throw Exception('Failed to send user query. Error: $e');
    }
  }
}


