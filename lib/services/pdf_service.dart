import 'dart:io';
// import 'package:pdf_text/pdf_text.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<String> extractText(String filePath) async {
    // final file = File(filePath);
    // final pdfDoc = await PDFDoc.fromFile(file);
    // String extractedText = await pdfDoc.text;
    // return extractedText;

    //! Syncfusion
    final PdfDocument document =
        PdfDocument(inputBytes: File(filePath).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return text;
  }
}
