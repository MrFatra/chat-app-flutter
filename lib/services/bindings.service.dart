import 'package:chat_app/services/connectivity.service.dart';
import 'package:chat_app/services/socket_io.client.service.dart';
import 'package:chat_app/services/store.service.dart';
import 'package:get/get.dart';

class ConnectivityBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<ConnectivityController>(ConnectivityController(), permanent: true);
    Get.put<SocketController>(SocketController(), permanent: true);
  }
}

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthStorage>(AuthStorage(), permanent: true);
  }
}
