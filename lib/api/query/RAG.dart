import "dart:convert";
import 'package:http/http.dart' as http;
import "package:logging/logging.dart";

class RAG {
  final String uploadPoint = "https://rag-s3.onrender.com/upload";
  final String ragPoint = "https://rag-s3.onrender.com/rag";
  final Logger _logger = Logger('RagService');

  Future<Map<String, dynamic>> indexTextIntoPinecone(
      String text, String file_name) async {
    final url = Uri.parse(uploadPoint);
    final Headers = {
      'Content-Type': 'application/json',
    };
    final Body = jsonEncode(
        {"text": text, "file_name": file_name, "index_name": "sem3"});

    //? Debug: Log the request details
    _logger.info('Request URL: $url');
    _logger.info('Request Headers: $Headers');
    _logger.info('Request Body: $Body');
    try {
      final response = await http.post(url, headers: Headers, body: Body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _logger.info('Response Body: $data');
        String documentId = data['document_id'];
        String indexName = data['index_name'];
        return {
          "document_id": documentId,
          "index_name": indexName,
        };
      } else {
        _logger.warning(
            "Failed to index text. Status code: ${response.statusCode}. Response Body: ${response.body}");
        throw Exception(
            "Failed to index text. Error Code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.warning("Failed to Index text. Error: $e");
      throw Exception('Failed to index text. Error: $e');
    }
  }

  sendUserQuery(String query, String file_name) async {
    final url = Uri.parse(ragPoint);
    final Headers = {
      'Content-Type': 'application/json',
    };
    final Body = jsonEncode({"query": query, "namespace": file_name});

    //? Debug: Log the request details
    _logger.info('Request URL: $url');
    _logger.info('Request Headers: $Headers');
    _logger.info('Request Body: $Body');
    try {
      final response = await http.post(url, headers: Headers, body: Body);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _logger.info('Response Body: $data');
        return data;
      } else {
        _logger.warning(
            "Failed to send user query. Status code: ${response.statusCode}. Response Body: ${response.body}");
        throw Exception(
            "Failed to send user query. Error Code: ${response.statusCode}");
      }
    } catch (e) {
      _logger.warning("Failed to send user query. Error: $e");
      throw Exception('Failed to send user query. Error: $e');
    }
  }
}
