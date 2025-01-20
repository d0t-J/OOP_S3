//! https://stackoverflow.com/questions/66685607/how-to-upload-files-pdf-doc-image-from-file-picker-to-api-server-on-flutter
//!https://stackoverflow.com/questions/49233934/how-to-open-and-pdf-or-word-document-in-the-flutter
//! https://stackoverflow.com/questions/76238373/how-to-view-pdf-in-flutter
//! StackOverflow.com
//! Reference for Uploading Files to API server on Flutter

//! https://pub.dev/packages/pdf_viewer_plugin
//! Reference for PDF Viewer Plugin

//! https://help.syncfusion.com/flutter/pdf-viewer/text-selection
//! Reference for Text Selection in PDF Viewer through Syncfusion PDF Viewer

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import '../../modules/pdf/readPDF.dart';
import '../query/translation_screen.dart';

class PdfUploadScreenState extends StatefulWidget {
  const PdfUploadScreenState({super.key});

  @override
  PdfUploadScreenStateState createState() => PdfUploadScreenStateState();
}

class PdfUploadScreenStateState extends State<PdfUploadScreenState> {
  String? filePath;
  String? fileName;
  String? extractedText;
  final PdfService pdfService = PdfService();
  final Logger _logger = Logger("PdfUploadScreenStateState");

  Future<void> pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
        fileName = getFileName(filePath!);
        extractedText = null;
        // Fix: Add bytes property for PDF file ( web issue )
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
        _logger.info("Extracted Text: $text");
        if (mounted) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TranslationScreen(
                        extractedText: text,
                        fileName: fileName!,
                      )));
        }
      } catch (e) {
        _logger.severe("Failed to extract content. Error $e");
      }
    }
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload File"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text("PDF"),
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text("Selected File: ${getFileName(filePath!)}"),
              ),
          ],
        ),
      ),
    );
  }
}
