import 'package:chat_app/controller/auth.controller.dart';
import 'package:chat_app/helper/validator.dart';
import 'package:chat_app/services/connectivity.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper/theme.dart';
import '../models/register.types.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final AuthController _authController = Get.put(AuthController());
  final ConnectivityController _connectivityController =
      Get.find<ConnectivityController>();

  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  final Rx<String> _selectedGender = ''.obs;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void registerFunc() {
    if (validate(_formKey)) {
      TRegister credentials = TRegister(
        fullName: _fullName.text,
        username: _username.text,
        password: _password.text,
        confirmPassword: _confirmPassword.text,
        gender: _selectedGender.value,
      );
      _authController.register(credentials);
    }
  }

  RxList<bool> isVisiblePass = [false, false].obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Register',
                        style: kHeadingTextStyle.copyWith(
                            color: const Color(0xFF55B3FF), fontSize: 32)),
                    Text(
                      'Enter form below.',
                      style: kBodyMediumTextStyle.copyWith(
                          color: const Color(0xFF91CBFA)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _fullName,
                      decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      validator: (value) => registerValidator(value),
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      validator: (value) => registerValidator(value),
                    ),
                    const SizedBox(height: 15), // Add some spacing between the fields
                    Obx(
                      () => TextFormField(
                        controller: _password,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  isVisiblePass[0] = !isVisiblePass[0],
                              icon: isVisiblePass[0]
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                        obscureText: isVisiblePass[0],
                        validator: (value) => registerValidator(
                          value,
                          type: TForm.password,
                          passwords: [_password.text, _confirmPassword.text],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Obx(
                      () => TextFormField(
                        controller: _confirmPassword,
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () =>
                                  isVisiblePass[1] = !isVisiblePass[1],
                              icon: isVisiblePass[1]
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off)),
                        ),
                        obscureText: isVisiblePass[1],
                        validator: (value) => registerValidator(
                          value,
                          passwords: [_password.text, _confirmPassword.text],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text('Select Gender: ', style: kBodyMediumTextStyle),
                    Obx(
                      () => Row(
                        children: [
                          Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                            child: Expanded(
                              child: RadioListTile(
                                  title:
                                      const Text('Male', style: kBodySmallTextStyle),
                                  value: 'male',
                                  groupValue: _selectedGender.value,
                                  onChanged: (value) {
                                    _selectedGender.value = value!;
                                  }),
                            ),
                          ),
                          Theme(
                            data: Theme.of(context).copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                            ),
                            child: Expanded(
                              child: RadioListTile(
                                  title: const Text('Female',
                                      style: kBodySmallTextStyle),
                                  value: 'female',
                                  groupValue: _selectedGender.value,
                                  onChanged: (value) {
                                    _selectedGender.value = value!;
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => ElevatedButton(
                        onPressed: _connectivityController.connected.value
                            ? registerFunc
                            : null,
                        child: Center(child: Obx(() {
                          if (_authController.isLoading.value) {
                            return const CircularProgressIndicator();
                          }
                          return const Text('Register');
                        })),
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Already have an account?'),
                        Obx(
                          () => _authController.isLoading.value
                              ? const SizedBox()
                              : TextButton(
                                  onPressed: () => Get.toNamed('/login'),
                                  child: const Text('Login'),
                                ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
