import 'dart:io';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<String> extractText(String filePath) async {
    final PdfDocument document =
        PdfDocument(inputBytes: File(filePath).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return _optimizeText(text.trim());
  }

  String _optimizeText(String text) {
    return text.replaceAll('\n', ' ').replaceAll('\r', ' ');
  }
}
