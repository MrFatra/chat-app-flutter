import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/store.service.dart';

class EnsureNotAuthedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthStorage authStorage = Get.find<AuthStorage>();

    debugPrint('auth storage: ${authStorage.logged.value}');

    if (authStorage.logged.value) {
      return null;
    }
    return super.redirect(route);
  }
}

class EnsureAuthedMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final AuthStorage authStorage = Get.find<AuthStorage>();

    debugPrint('auth storage: ${authStorage.logged.value}');

    if (!authStorage.logged.value) {
      return const RouteSettings(name: '/login');
    }
    return super.redirect(route);
  }
}
