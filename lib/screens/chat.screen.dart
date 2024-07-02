import 'package:chat_app/controller/message.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final user = Get.arguments['user'];

  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final RxBool atBottom = false.obs;
  bool initialLoad = true;

  @override
  Widget build(BuildContext context) {
    final MessageController messageController =
        Get.put(MessageController(id: user.id));

    ever(messageController.messages, (messages) {
      if (messages.isNotEmpty && initialLoad) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,
            );
            initialLoad = false;
          }
        });
      }
    });

    void scrollToNewMessages() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    }

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        atBottom.value = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent;
      } else {
        atBottom.value = false;
      }
    });

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: Obx(() => atBottom.value || messageController.messages.isEmpty
          ? SizedBox.shrink()
          : Align(
            alignment: Alignment(1, .8),
            child: FloatingActionButton.small(
                onPressed: scrollToNewMessages,
                child: const Icon(Icons.arrow_downward, color: Colors.white),
              ),
          )),
      appBar: AppBar(
        title: Text(user.fullName),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Obx(() => ListView.builder(
                    controller: _scrollController,
                    itemCount: messageController.messages.length,
                    itemBuilder: (context, index) {
                      final message = messageController.messages[index];
                      final isSender = message.receiverId == user.id;

                      return Align(
                        alignment: isSender
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color:
                                isSender ? Colors.blueAccent : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: isSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                message.message,
                                style: TextStyle(
                                    color:
                                        isSender ? Colors.white : Colors.black),
                              ),
                              SizedBox(height: 5),
                              Text(
                                message.createdAt.toString(),
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isSender
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Type your message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      messageController.sendMessage(
                          _textController.text, user.id);
                      _textController.clear();
                    },
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
