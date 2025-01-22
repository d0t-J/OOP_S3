class RAGModel {
  final String? documentId;
  final String? indexName;
  final String? response;

  RAGModel({
    this.documentId,
    this.indexName,
    this.response,
  });

  factory RAGModel.fromJson(Map<String, dynamic> json) {
    return RAGModel(
      documentId: json['document_id'] as String?,
      indexName: json['index_name'] as String?,
      response: json['response'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (documentId != null) 'document_id': documentId,
      if (indexName != null) 'index_name': indexName,
      if (response != null) 'response': response,
    };
  }
}
