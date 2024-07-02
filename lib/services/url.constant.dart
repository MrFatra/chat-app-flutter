// ignore_for_file: constant_identifier_names

class URL {
  static const SOCKET_HOST = 'http://192.168.100.32:3000'; // 10.0.2.2:3000
  static const BASE_URL = '$SOCKET_HOST/api';
}

class Routes {
  static const splash = '/splash';
  static const noConnection = '/no-connection';
  static const root = '/';
  static const chat = '/chat';
  static const register = '/register';
  static const login = '/login';
}