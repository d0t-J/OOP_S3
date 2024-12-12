//! https://stackoverflow.com/questions/66685607/how-to-upload-files-pdf-doc-image-from-file-picker-to-api-server-on-flutter
//!https://stackoverflow.com/questions/49233934/how-to-open-and-pdf-or-word-document-in-the-flutter
//! https://stackoverflow.com/questions/76238373/how-to-view-pdf-in-flutter
//! StackOverflow.com
//! Reference for Uploading Files to API server on Flutter

//! https://pub.dev/packages/pdf_viewer_plugin
//! Reference for PDF Viewer Plugin

//! https://help.syncfusion.com/flutter/pdf-viewer/text-selection
//! Reference for Text Selection in PDF Viewer through Syncfusion PDF Viewer

// 
// This file defines a Flutter widget for uploading and handling PDF files.
// It uses the `file_picker` package to allow users to select a PDF file from their device,
// and a custom `PdfService` to extract text content from the selected PDF file.
// The `logging` package is used to log information about the extracted text.

import 'package:file_picker/file_picker.dart'; // Importing the file_picker package to allow file selection from the device.
import 'package:flutter/material.dart'; // Importing Flutter's material design library for UI components.
import 'package:logging/logging.dart'; // Importing the logging package to log information.
import '../services/pdf_service.dart'; // Importing a custom service for handling PDF operations.

// A stateful widget that represents the home screen of the application.
class HomeScreen extends StatefulWidget {
  // Creates a HomeScreen widget.
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState(); // Creating the state for the HomeScreen widget.
}

// The state class for the HomeScreen widget.
class HomeScreenState extends State<HomeScreen> {
  // Variable to store the path of the selected file.
  String? filePath;

  // Instance of PdfService to handle PDF operations.
  final PdfService pdfService = PdfService();

  // Logger instance for logging information.
  final Logger _logger = Logger("HomeScreenState");

  // Method to pick a PDF file from the device.
  // 
  // This method uses the `FilePicker` package to open a file picker dialog
  // that allows the user to select a PDF file. If a file is selected, its
  // path is stored in the `filePath` variable.
  Future<void> pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']); // Using FilePicker to pick a PDF file.
    if (result != null) {
      setState(() {
        filePath = result.files.single.path; // Storing the path of the selected file.
        // Fix: Add bytes property for PDF file
      });
    }
  }

  // Method to extract text content from the selected PDF file.
  // 
  // This method checks if a file has been selected by verifying that `filePath` is not null.
  // If a file has been selected, it uses the `PdfService` to extract text content from the PDF file
  // and logs the extracted text using the `_logger` instance.
  Future<void> extractPdfContent() async {
    if (filePath != null) {
      final text = await pdfService.extractText(filePath!); // Extracting text from the PDF file using PdfService.
      _logger.info("Extracted Text: $text"); // Logging the extracted text.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Handling"), // Setting the title of the app bar.
        backgroundColor: Colors.blue, // Setting the background color of the app bar.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centering the column's children vertically.
          children: [
            ElevatedButton(
              onPressed: pickFile, // Setting the onPressed callback to pickFile method.
              child: Text("Upload PDF"), // Setting the button text.
            ),
            if (filePath != null)
              Padding(
                padding: const EdgeInsets.all(8.0), // Adding padding around the text widget.
                child: Text("Selected File: $filePath"), // Displaying the path of the selected file.
              ),
          ],
        ),
      ),
    );
  }
}
