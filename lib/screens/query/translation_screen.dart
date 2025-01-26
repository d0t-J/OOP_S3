import 'package:flutter/material.dart';
import "package:logger/logger.dart";
import 'package:test_/utils/log/logger_util.dart';
import 'package:test_/widgets/loading.dart';

import 'package:test_/repository/translation/translation_repository.dart';
import 'package:test_/models/translation/translation_model.dart';
import "package:test_/repository/query/rag_repository.dart";
import "package:test_/models/query/rag_model.dart";

class TranslationScreen extends StatefulWidget {
  final String extractedText;
  final String fileName;

  const TranslationScreen(
      {required this.extractedText, required this.fileName, super.key});

  @override
  TranslationScreenState createState() => TranslationScreenState();
}

class TranslationScreenState extends State<TranslationScreen> {
  final Logger _logger = LoggerUtil.createLogger();

  final TranslationRepository _Translator = TranslationRepository();
  final RAGRepository _RAG = RAGRepository();

  String _translatedText = "";
  bool _isLoading = false;

  void _handleTranslation() async {
    setState(() => _isLoading = true);
    try {
      _logger.i(
          "translation_screen.dart\nExtracted Text: ${widget.extractedText}");
      TranslationResult result =
          await _Translator.translate(widget.extractedText, 'en');
      setState(() => _translatedText = result.translatedText);
      _logger.i("translation_screen.dart\nTranslated Text: $_translatedText");

      if (_translatedText.isNotEmpty) {
        setState(() => _isLoading = false);
        await _uploadToPinecone();
      } else {
        _logger.e(
            "translation_screen.dart\nTranslated text is empty. Skipping upload to Pinecone.");
      }
    } catch (e) {
      setState(() => _translatedText = "Error occurred while translating $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _uploadToPinecone() async {
    if (_translatedText.isEmpty) {
      _logger.e(
          "translation_screen.dart\nTranslated text is empty. Skipping upload to Pinecone.");
    }
    try {
      RAGModel indexResponse =
          await _RAG.indexTextIntoPinecone(_translatedText, widget.fileName);
      _logger.i(
          "translation_screen.dart\nIndex Upload Response: ${indexResponse.toJson()}");
      print("Index Upload Response: ${indexResponse.toJson()}");
    } catch (e) {
      _logger.e(
          "translation_screen.dart\nFailed to upload to Pinecone due to error: $e");
      throw Exception("Failed to upload to Pinecone: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _handleTranslation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation"),
        backgroundColor: const Color.fromARGB(255, 118, 98, 228),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Translation",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Original Text:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: Text(
                          widget.extractedText.replaceAll('\n', ' ').trim(),
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const LoadingWidget()
                  : Card(
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Translated Text:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              child: Text(
                                _translatedText.trim().replaceAll('\n', ' '),
                                softWrap: true,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.left,
                                // textDirection: TextDirection.ltr,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
