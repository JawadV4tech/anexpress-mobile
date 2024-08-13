import 'package:anexpress/core/extensions/log_extension.dart';
import 'package:encrypt/encrypt.dart';

/// encrypt a string
String encryptString(String plainText) {
  final key = Key.fromUtf8('8JOFWUblgarVNN2S6u4vkihmXFaQFnTJ');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));

  final encrypted = encrypter.encrypt(plainText, iv: iv);

  final encryptedString = encrypted.base64;
  'saving this encrypted string: $encryptedString'.log();
  return encryptedString;
}

String decryptString(String encrypted) {
  'inside decryptString received  this encrypted string: $encrypted'.log();
  final key = Key.fromUtf8('8JOFWUblgarVNN2S6u4vkihmXFaQFnTJ');
  final iv = IV.fromLength(16);

  final encrypter = Encrypter(AES(key));
  final decrypted = encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);

  'decrypted string: $decrypted'.log();

  return decrypted;
}
