import 'dart:io';
import 'package:pdf_text/pdf_text.dart';

class PdfService {
  Future<String> extractText(String filePath) async {
    final file = File(filePath);
    final pdfDoc = await PDFDoc.fromFile(file);
    String extractedText = await pdfDoc.text;
    return extractedText;
  }
}

