import 'package:chat_app/controller/auth.controller.dart';
import 'package:chat_app/helper/validator.dart';
import 'package:chat_app/helper/theme.dart';
import 'package:chat_app/helper/types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/connectivity.service.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController _authController = Get.put(AuthController());
  final ConnectivityController _connectivityController =
      Get.find<ConnectivityController>();

  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final RxBool isVisible = false.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _loginFunc() {
    if (validate(_formKey)) {
      FocusManager.instance.primaryFocus?.unfocus();
      TLogin credentials = TLogin(
        username: _username.text.trim(),
        password: _password.text.trim(),
      );
      _authController.login(credentials);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Login',
                      style: kHeadingTextStyle.copyWith(
                          color: const Color(0xFF1171C0), fontSize: 32)),
                  Text('Enter username and password below.',
                      style: kBodyMediumTextStyle.copyWith(
                          color: Colors.blue)),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _username,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7),
                        borderSide: const BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (value) => loginValidator(value),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => TextFormField(
                      controller: _password,
                      obscureText: isVisible.value,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () => isVisible.value = !isVisible.value,
                            icon: isVisible.value
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off)),
                        hintText: 'Password',
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                          borderSide: const BorderSide(
                            color: Colors.red,
                            width: 2,
                          ),
                        ),
                      ),
                      validator: (value) => loginValidator(value),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => ElevatedButton(
                      onPressed: _connectivityController.connected.value
                          ? _loginFunc
                          : null,
                      child: const Center(
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () => Get.toNamed('/register'),
                        child: const Text('Register'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
