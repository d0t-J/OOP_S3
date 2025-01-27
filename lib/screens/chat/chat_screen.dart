import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import "package:jumping_dot/jumping_dot.dart";
import "package:flutter_markdown/flutter_markdown.dart";

import "package:test_/widgets/bubble_two.dart";
import "package:test_/modules/query/query_processing.dart";
import "package:test_/utils/log/logger_util.dart";

class ChatScreen extends StatefulWidget {
  final String indexName = "sem3";
  final String? documentId;
  final String fileName;
  final bool isLoading;

  const ChatScreen(
      {required this.documentId,
      required this.fileName,
      this.isLoading = false,
      super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool _isLoading = false;
  bool _isUserScrolling = false;
  final Logger _logger = LoggerUtil.createLogger();
  final QueryProcessingService queryProcessingService =
      QueryProcessingService();
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, String>> _messages = [];

  @override
  void initState() {
    super.initState();
    _isLoading = widget.isLoading;
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection !=
          ScrollDirection.idle) {
        _isUserScrolling = true;
      } else {
        _isUserScrolling = false;
      }
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(
        _scrollController.position.maxScrollExtent,
      );
    }
  }

  Future<void> _sendMessage(String query) async {
    if (query.isEmpty || _isLoading) return;

    setState(() {
      _messages.add({'user': query});
      _isLoading = true;
    });

    if (!_isUserScrolling) {
      _scrollToBottom();
    }

    try {
      String response =
          await queryProcessingService.sendUserMessage(query, widget.fileName);
      for (int i = 0; i <= response.length; i++) {
        if (mounted) {
          setState(() {
            if (i == 0) _messages.add({'bot': ''});
            _messages.last['bot'] = response.substring(0, i);
          });
          if (!_isUserScrolling) {
            _scrollToBottom();
          }
        }
        await Future.delayed(const Duration(milliseconds: 15));
      }
    } catch (e) {
      _logger.e("chat_screen.dart:\nFailed to send message: $e");
      if (mounted) {
        setState(() {
          _messages.add({'bot': "Unable to fetch response."});
        });
        if (!_isUserScrolling) {
          _scrollToBottom();
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.fileName,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 118, 98, 228),
      ),
      backgroundColor: const Color.fromARGB(255, 227, 223, 249),
      body: Column(
        children: [
          if (widget.isLoading)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: LinearProgressIndicator(
                backgroundColor: const Color.fromARGB(255, 227, 223, 249),
                color: const Color.fromARGB(255, 103, 89, 186),
              ),
            ),
          if (!widget.isLoading) ...[
            Expanded(
              child: LayoutBuilder(builder: (context, constraints) {
                return ListView.builder(
                  controller: _scrollController,
                  physics: const ClampingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final message = _messages[index];
                    final isUser = message.containsKey("user");
                    return Align(
                      alignment:
                          isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        child: isUser
                            ? CustomBubbleSpecialOne(
                                text: message['user']!,
                                color: const Color.fromARGB(255, 168, 159, 221),
                                isSender: true,
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                              )
                            : CustomBubbleSpecialOne(
                                color: const Color.fromARGB(255, 103, 89, 186),
                                isSender: false,
                                text: "",
                                textStyle: const TextStyle(
                                    fontSize: 16, color: Colors.white),
                                customChild: MarkdownBody(
                                  data: message['bot']!,
                                  styleSheet: MarkdownStyleSheet(
                                    p: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    );
                  },
                );
              }),
            ),
            if (_isLoading)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: JumpingDots(
                  color: Color.fromARGB(255, 103, 89, 186),
                  numberOfDots: 3,
                  animationDuration: Duration(milliseconds: 300),
                ),
              ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_isLoading,
                      decoration: const InputDecoration(
                        hintText: "Enter message...",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 1.0, vertical: 15.0),
                    ),
                    onPressed: !_isLoading
                        ? () {
                            final query = _controller.text.trim();
                            if (query.isNotEmpty) {
                              _sendMessage(query);
                              _controller.clear();
                            }
                          }
                        : null,
                    child: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
          if (widget.isLoading)
            Expanded(
              child: Center(
                child: Text(
                  "Processing your file...",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
