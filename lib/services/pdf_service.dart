import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<String> extractText(String filePath) async {
    //! Syncfusion
    final PdfDocument document =
        PdfDocument(inputBytes: File(filePath).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return text;

    // Fix: Add Data Cleaning Steps like removing special characters, line breaks and getting just the plain text with characters only.
  }
}
