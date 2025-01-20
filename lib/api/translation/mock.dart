import 'translation_service.dart';

class MockTranslationService extends TranslationService {
  @override
  Future<String> translateText(String text, String targetLanguage) async {
    await Future.delayed(Duration(seconds: 1));

    Map<String, String> mockTranslations = {
      " کسان زراعت": "Farmers agriculture",
      "کیا حال ہے؟": "How are you?",
      "آپ کا شکریہ۔": "Thank you.",
    };

    return mockTranslations[text] ?? "Mock Translation for $text";
  }
}

// ! Mock Translation Screen
// class TranslationScreen extends StatefulWidget {
//   final String extractedText;
//   final bool useMock; // Flag to enable mock service

//   const TranslationScreen(
//       {required this.extractedText, this.useMock = false, Key? key})
//       : super(key: key);

//   @override
//   TranslationScreenState createState() => TranslationScreenState();
// }

// class TranslationScreenState extends State<TranslationScreen> {
//   late final TranslationRepository _repository;
//   String _translatedText = "";
//   bool _isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     _repository = TranslationRepository(useMock: widget.useMock);
//     _handleTranslation();
//   }

//   void _handleTranslation() async {
//     setState(() => _isLoading = true);
//     try {
//       TranslationResult result =
//           await _repository.translate(widget.extractedText, 'en');
//       setState(() => _translatedText = result.translatedText);
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Translation")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Original Text:",
//                 style: TextStyle(fontWeight: FontWeight.bold)),
//             Text(widget.extractedText),
//             SizedBox(height: 20),
//             _isLoading
//                 ? LoadingWidget()
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("Translated Text:",
//                           style: TextStyle(fontWeight: FontWeight.bold)),
//                       Text(_translatedText),
//                     ],
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
