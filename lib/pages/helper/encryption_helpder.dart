import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';

class EncryptHelper {
  static final _key =
      encrypt.Key.fromUtf8('16byteslongivkey'); // Must be 32 chars
  static final _iv =
      encrypt.IV.fromUtf8('16byteslongivkey'); // Must be 16 chars

  static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  /// Step 1: Hash with SHA-256
  static String _hashWithSHA256(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString(); // Hex representation
  }

  /// Step 2: Encrypt hashed string with AES
  static String encryptText(String plainText) {
    final hashed = _hashWithSHA256(plainText);
    final encrypted = _encrypter.encrypt(hashed, iv: _iv);
    return encrypted.base64;
  }

  /// Step 3: Decrypt AES -> get hash string
  static String decryptText(String encryptedText) {
    return _encrypter.decrypt64(encryptedText, iv: _iv);
  }
}
