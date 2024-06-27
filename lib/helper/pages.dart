import 'package:chat_app/middleware/auth.dart';
import 'package:chat_app/screens/home.screen.dart';
import 'package:chat_app/screens/login.screen.dart';
import 'package:chat_app/screens/register.screen.dart';
import 'package:chat_app/screens/splash.screen.dart';
import 'package:get/get.dart';

import '../screens/no_connection.screen.dart';

List<GetPage<dynamic>>? pageList() {
  return [
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/no-connection',
      page: () => NoConnectionScreen(),
    ),
    GetPage(
        name: '/',
        page: () => HomeScreen(),
        middlewares: [EnsureAuthedMiddleware()]),
    GetPage(
        name: '/register',
        page: () => RegisterScreen(),
        middlewares: [EnsureNotAuthedMiddleware()]),
    GetPage(
        name: '/login',
        page: () => LoginScreen(),
        middlewares: [EnsureNotAuthedMiddleware()]),
  ];
}
