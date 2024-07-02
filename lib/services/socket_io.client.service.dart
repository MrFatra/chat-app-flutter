import 'package:chat_app/services/url.constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketController extends GetxController {
  late final IO.Socket socket;
  var socketConnected = false.obs;

  @override
  void onInit() {
    super.onInit();
    connectToSocket();
  }

  @override
  void onClose() {
    super.onClose();
    socket.dispose();
  }

  void connectToSocket() {
    socket = IO.io(
        URL.SOCKET_HOST,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableReconnection()
            .build());

    socket.onConnect((_) {
      socketConnected.value = true;
      debugPrint('Connected to the server!');
      debugPrint('Your socket id is ${socket.id}');
    });

    socket.onReconnect((data) {
      debugPrint('Reconnected to the server!');
    });

    socket.onReconnectAttempt((data) {
      debugPrint('Reconnecting to the server...');
    });

    socket.onReconnectError((data) {
      socketConnected.value = false;
      debugPrint('Error reconnecting to the server: $data');
    });

    socket.onReconnectFailed((data) {
      socketConnected.value = false;
      debugPrint('Failed to reconnect to the server: $data');
    });

    socket.onConnectError((data) {
      socketConnected.value = false;
      debugPrint('Connection error: $data');
    });

    socket.onDisconnect((data) {
      socketConnected.value = false;
      debugPrint('Disconnected: $data');
    });
  }
}
