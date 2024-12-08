import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PDFUploadPage extends StatelessWidget {
  const PDFUploadPage({Key? key}) : super(key: key);

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result == null) {
      Fluttertoast.showToast(msg: 'No file selected');
      return;
    } else {
      //! final file = result.files.single.path!;
      final file = result.files.single;
      Fluttertoast.showToast(msg: 'File picked: ${file.name}');
      //TODO: Upload the file to a PDF processing service
      //* Steps
      //* 1. Create an HTTP request to the PDF processing service ( check services\pdf_service.dart ).
      //* 2. Attach the picked file to the request.
      //* 3. Send the request and handle the response.
      //* 4. Show a success or error message based on the response.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Upload')),
      body: Center(
        child: ElevatedButton(
          onPressed: pickFile,
          child: const Text('Pick a PDF file'),
        ),
      ),
    );
  }
}