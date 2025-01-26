import "dart:convert";
import 'package:logger/logger.dart';
import "package:test_/utils/log/logger_util.dart";
import 'package:http/http.dart' as http;

class RAG {
  final Logger _logger = LoggerUtil.createLogger();
  final String uploadPoint = "https://rag-s3.onrender.com/upload";
  final String ragPoint = "https://rag-s3.onrender.com/rag";

  Future<Map<String, dynamic>> indexTextIntoPinecone(
      String text, String file_name) async {
    _logger.i("RAG.dart\nindexTextIntoPinecone()");
    final url = Uri.parse(uploadPoint);
    final Headers = {
      'Content-Type': 'application/json',
    };
    final Body = jsonEncode({"text": text, "file_name": file_name});

    //? Debug: Log the request details
    _logger.i('Request:\nURL: $url\nHeaders: $Headers\nRequest Body: $Body');
    try {
      final response = await http.post(url, headers: Headers, body: Body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _logger.i('RAG.dart:\nResponse Body: $data');
        String documentId = data['document_id'];
        String indexName = data['index_name'];
        return {
          "document_id": documentId,
          "index_name": indexName,
        };
      } else {
        _logger.e(
            "RAG.dart:\nFailed to index text. Status code: ${response.statusCode}. Response Body: ${response.body}");
        throw Exception(
            "Failed to index text. Error Code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("RAG.dart:\nFailed to Index text. Error: $e");
      throw Exception('Failed to index text. Error: $e');
    }
  }

  Future<Map<String, dynamic>> sendUserQuery(
      String query, String file_name) async {
    _logger.i("RAG.dart\nsendUserQuery()");
    final url = Uri.parse(ragPoint);
    final Headers = {
      'Content-Type': 'application/json',
    };
    final Body = jsonEncode({"query": query, "namespace": file_name});

    //? Debug: Log the request details
    _logger.i('Request:\nURL: $url\nHeaders: $Headers\nRequest Body: $Body');
    try {
      final response = await http.post(url, headers: Headers, body: Body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _logger.i('\nResponse:\n $data');
        return data;
      } else {
        _logger.e(
            "Failed to send user query. Status code: ${response.statusCode}. Response Body: ${response.body}");
        throw Exception(
            "Failed to send user query. Error Code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.e("RAG.dart:\nFailed to send user query. Error: $e");
      throw Exception('Failed to send user query. Error: $e');
    }
  }
}
