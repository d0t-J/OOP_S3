import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PdfService {
  Future<FilePickerResult?> pickPDF() async {
    return await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  }

  String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  Future<String> extractText(String filePath) async {
    final PdfDocument document =
        PdfDocument(inputBytes: File(filePath).readAsBytesSync());
    String text = PdfTextExtractor(document).extractText();
    document.dispose();
    return _optimizeText(text.trim());
  }

  String _optimizeText(String text) {
    text = text.replaceAll(RegExp(r'\s+'), ' ');
    return text;
  }
}
