import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import "package:test_/utils/log/logger_util.dart";
import "package:test_/modules/pdf/pdf_helper.dart";
import "package:test_/modules/translation/translate.dart";
import "package:test_/modules/query/query_processing.dart";
import "package:test_/screens/chat/chat_screen.dart";
import "package:test_/widgets/breathing_button.dart";

class PdfUploadScreenState extends StatefulWidget {
  const PdfUploadScreenState({super.key});

  @override
  PdfUploadScreenStateState createState() => PdfUploadScreenStateState();
}

class PdfUploadScreenStateState extends State<PdfUploadScreenState> {
  final Logger _logger = LoggerUtil.createLogger();

  String? filePath;
  String? fileName;
  String? extractedText;
  final PdfService pdfService = PdfService();
  final TranslationService translationService = TranslationService();
  final QueryProcessingService queryProcessingService =
      QueryProcessingService();

  Future<void> pickFile() async {
    final result = await pdfService.pickPDF();
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        fileName = pdfService.getFileName(filePath!);
        extractedText = null;
      });
      await extractPdfContent();
    }
  }

  Future<void> extractPdfContent() async {
    if (filePath != null) {
      try {
        final text = await pdfService.extractText(filePath!);
        setState(() {
          extractedText = text;
        });
        _logger.i("pdf_upload.dart:\nExtracted Text: $text");
        await translateAndUploadText(text);
      } catch (e) {
        _logger.e("pdf_upload.dart:\nFailed to extract content. Error $e");
      }
    }
  }

  Future<void> translateAndUploadText(String text) async {
    try {
      final translatedText = await translationService.translateText(text, 'en');
      _logger.i("pdf_upload.dart:\nTranslated Text: $translatedText");
      final indexResponse = await queryProcessingService.uploadToPinecone(
          translatedText, fileName!);
      _logger.i("pdf_upload.dart:\nIndex Response: ${indexResponse.toJson()}");
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              documentId: indexResponse.documentId!,
              fileName: fileName!,
            ),
          ),
        );
      }
    } catch (e) {
      _logger.e("pdf_upload.dart:\nFailed to translate and upload text $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 118, 98, 228),
      ),
      backgroundColor: const Color.fromARGB(255, 227, 223, 249),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Upload a PDF file to start a chat',
              style: TextStyle(fontSize: 20),
            ),
            Padding(padding: const EdgeInsets.all(3.0)),
            BreathingButton(
              onPressed: pickFile,
              text: "PDF",
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Selected File: $fileName"),
              ),
          ],
        ),
      ),
    );
  }
}
