import 'package:flutter/material.dart';
import 'package:chat_bubbles/bubbles/bubble_special_one.dart';

class CustomBubbleSpecialOne extends BubbleSpecialOne {
  final Widget? customChild;

  const CustomBubbleSpecialOne({
    Key? key,
    this.customChild,
    bool isSender = true,
    String text = "",
    bool tail = true,
    Color color = Colors.white70,
    bool sent = false,
    bool delivered = false,
    bool seen = false,
    TextStyle textStyle = const TextStyle(
      color: Colors.black87,
      fontSize: 16,
    ),
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isSender: isSender,
          text: text,
          tail: tail,
          color: color,
          sent: sent,
          delivered: delivered,
          seen: seen,
          textStyle: textStyle,
          constraints: constraints,
        );

  @override
  Widget build(BuildContext context) {
    bool stateTick = false;
    Icon? stateIcon;

    // Determine the state icon based on message status
    if (sent) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (delivered) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF97AD8E),
      );
    }
    if (seen) {
      stateTick = true;
      stateIcon = const Icon(
        Icons.done_all,
        size: 18,
        color: Color(0xFF92DEDA),
      );
    }

    return Align(
      alignment: isSender ? Alignment.topRight : Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: CustomPaint(
          painter: SpecialChatBubbleOne(
            color: color,
            alignment: isSender ? Alignment.topRight : Alignment.topLeft,
            tail: tail,
          ),
          child: Container(
            constraints: constraints ??
                BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7,
                ),
            margin: isSender
                ? stateTick
                    ? const EdgeInsets.fromLTRB(7, 7, 14, 7)
                    : const EdgeInsets.fromLTRB(7, 7, 17, 7)
                : const EdgeInsets.fromLTRB(17, 7, 7, 7),
            child: Stack(
              children: <Widget>[
                customChild != null
                    ? Padding(
                        padding: stateTick
                            ? const EdgeInsets.only(right: 20)
                            : const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                        child: customChild,
                      )
                    : Padding(
                        padding: stateTick
                            ? const EdgeInsets.only(right: 20)
                            : const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 0),
                        child: Text(
                          text,
                          style: textStyle,
                          textAlign: TextAlign.left,
                        ),
                      ),
                stateIcon != null && stateTick
                    ? Positioned(
                        bottom: 0,
                        right: 0,
                        child: stateIcon,
                      )
                    : const SizedBox(
                        width: 1,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
