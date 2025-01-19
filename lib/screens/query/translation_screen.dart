import 'package:flutter/material.dart';
import 'package:test_/modules/translation/translation_repository.dart';
import 'package:test_/models/translation/translation_model.dart';
import 'package:test_/widgets/loading.dart';

class TranslationScreen extends StatefulWidget {
  final String extractedText;
  const TranslationScreen({required this.extractedText, Key? key})
      : super(key: key);

  @override
  TranslationScreenState createState() => TranslationScreenState();
}

class TranslationScreenState extends State<TranslationScreen> {
  final TranslationRepository _repository = TranslationRepository();
  String _translatedText = "";
  bool _isLoading = false;

  void _handleTranslation() async {
    setState(() => _isLoading = true);
    try {
      print("Extracted Text: ${widget.extractedText}");
      TranslationResult result =
          await _repository.translate(widget.extractedText, 'en');
      setState(() => _translatedText = result.translatedText);
      print("Translated Text: $_translatedText");
    } catch (e) {
      setState(() => _translatedText = "Error occurred while translating $e");
    } finally {
      setState(() => _isLoading = false);
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
        backgroundColor: const Color.fromARGB(255, 41, 176, 234),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Translation Module",
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
