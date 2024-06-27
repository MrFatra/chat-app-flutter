import 'package:flutter/rendering.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:get/get.dart';

class AuthStorage extends GetxController {
  final FlutterSecureStorage storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  RxBool logged = false.obs;

  Future<bool> initializeLoggedInStatus() async {
    logged.value = await isLoggedIn;
    return logged.value;
  }

  Future<void> storeToken(String token) async {
    await storage.write(key: 'user', value: token);
    logged.value = await isLoggedIn;
  }

  Future<String?> get token async {
    return await storage.read(key: 'user') ?? '';
  }

  static bool isTokenExpired(String token) {
    final decodedToken = JwtDecoder.decode(token);
    debugPrint('decodedToken: $decodedToken');
    return JwtDecoder.isExpired(token);
  }

  Future<bool> get isLoggedIn async {
    String? currentToken = await token;
    debugPrint('currentToken: $currentToken');
    debugPrint((currentToken == null ||
            currentToken.isEmpty ||
            isTokenExpired(currentToken))
        .toString());
    if (currentToken == null ||
        currentToken.isEmpty ||
        isTokenExpired(currentToken)) {
      return false;
    } else {
      return await isValidToken(currentToken);
    }
  }

  Future<bool> isValidToken(String token) async {
    if (token.isEmpty) {
      return false;
    } else {
      try {
        JwtDecoder.decode(token);
        debugPrint('isValid!');
        return !isTokenExpired(token);
      } catch (err) {
        return false;
      }
    }
  }

  Future<void> logout() async {
    await storage.delete(key: 'user');
    logged.value = false;
  }
}
