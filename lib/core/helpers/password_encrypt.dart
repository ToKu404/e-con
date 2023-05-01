import 'dart:math';
import 'package:encrypt/encrypt.dart';

class PasswordEncrypt {
  static final _iv = IV.fromLength(16); // 16 bytes
  static final _key = Key.fromSecureRandom(16);
  static final _encrypter = Encrypter(AES(_key));

  static String encrypt(String password) {
    final enc = _encrypter.encrypt('${password}@sifa.unhas.ac.id', iv: _iv);
    return enc.base64;
  }

  static String decrypt(String password) {
    final enc = Encrypted.fromBase64(password);
    final dec = _encrypter.decrypt(enc, iv: _iv);
    return dec.replaceFirst('@sifa.unhas.ac.id', '');
  }
}
