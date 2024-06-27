import 'dart:math';

String generateRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();
  return String.fromCharCodes(
    List.generate(
      length, 
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}