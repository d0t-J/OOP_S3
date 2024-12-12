import 'package:flutter/material.dart';
import '../ui/pdf_upload.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 47, 6, 122)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}