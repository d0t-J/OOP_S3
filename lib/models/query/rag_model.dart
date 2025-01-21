class RAGModel {
  final String documentId;
  final String indexName;
  final String response;

  RAGModel({
    required this.documentId,
    required this.indexName,
    required this.response,
  });

  factory RAGModel.fromJson(Map<String, dynamic> json) {
    return RAGModel(
      documentId: json['document_id'],
      indexName: json['index_name'],
      response: json['response'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'document_id': documentId,
      'index_name': indexName,
      'response': response,
    };
  }
}
