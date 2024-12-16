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
import '../services/pdf_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? filePath;
  String? extractedText;
  final PdfService pdfService = PdfService();
  final Logger _logger = Logger("HomeScreenState");

  Future<void> pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null) {
      setState(() {
        filePath = result.files.single.path;
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
      } catch (e) {
        _logger.severe("Failed to extract content");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Handling"),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: pickFile,
              child: Text("Upload PDF"),
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Selected File: $filePath"),
              ),
            if (extractedText != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Extracted Text: $extractedText"),
              ),
          ],
        ),
      ),
    );
  }
}
