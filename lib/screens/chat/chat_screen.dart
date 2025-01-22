// ignore_for_file: unused_import, library_private_types_in_public_api, use_super_parameters

import "package:flutter/material.dart";
import 'package:logger/logger.dart';
import "package:test_/utils/log/logger_util.dart";

import "package:test_/api/query/RAG.dart";
import "package:test_/widgets/loading.dart";
import "package:test_/screens/query/translation_screen.dart";

class ChatScreen extends StatefulWidget {
  final String documentId;
  final String indexName = "sem3";

  const ChatScreen({required this.documentId, Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final RAG rag = RAG();
  final Logger _logger = LoggerUtil.createLogger();
  final List<String> _messages = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter a message",
                    ),
                    onSubmitted: (text) {
                      setState(() {
                        _messages.add(text);
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add send button functionality here
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
