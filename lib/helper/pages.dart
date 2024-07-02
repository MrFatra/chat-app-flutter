import 'package:chat_app/middleware/auth.dart';
import 'package:chat_app/screens/chat.screen.dart';
import 'package:chat_app/screens/home.screen.dart';
import 'package:chat_app/screens/login.screen.dart';
import 'package:chat_app/screens/register.screen.dart';
import 'package:chat_app/screens/splash.screen.dart';
import 'package:get/get.dart';

import '../screens/no_connection.screen.dart';
import '../services/url.constant.dart';

List<GetPage<dynamic>>? pageList() {
  return [
    GetPage(
      name: Routes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: Routes.noConnection,
      page: () => NoConnectionScreen(),
    ),
    GetPage(
        name: Routes.root,
        page: () => HomeScreen(),
        middlewares: [EnsureAuthedMiddleware()]),
    GetPage(
        name: Routes.chat,
        page: () => ChatScreen(),
        middlewares: [EnsureAuthedMiddleware()]),
    GetPage(
        name: Routes.register,
        page: () => RegisterScreen(),
        middlewares: [EnsureNotAuthedMiddleware()]),
    GetPage(
        name: Routes.login,
        page: () => LoginScreen(),
        middlewares: [EnsureNotAuthedMiddleware()]),
  ];
}
