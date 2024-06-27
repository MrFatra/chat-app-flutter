import 'package:chat_app/material.dart';
import 'package:chat_app/services/bindings.service.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ConnectivityBindings().dependencies();
  AuthBindings().dependencies();

  runApp(const MainMaterial());
}
