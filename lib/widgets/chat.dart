import 'package:bubble/bubble.dart';
import 'package:chat_app/helper/formatter.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.isSender,
    required this.message,
    required this.date,
  });
  final bool isSender;
  final String message;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Bubble(
        elevation: 0,
        stick: isSender,
        padding: const BubbleEdges.all(10),
        nip: isSender ? BubbleNip.rightTop : BubbleNip.leftTop,
        alignment: isSender ? Alignment.topRight : Alignment.topLeft,
        color: isSender ? Colors.blueAccent : Colors.grey[300],
        child: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          child: Column(
            crossAxisAlignment:
                isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                message,
                style: TextStyle(color: isSender ? Colors.white : Colors.black),
              ),
              const SizedBox(height: 5),
              Text(
                formatDate(date),
                style: TextStyle(
                  fontSize: 10,
                  color: isSender ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
