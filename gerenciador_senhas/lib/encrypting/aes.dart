import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';
import 'package:encrypt/encrypt.dart';
// import 'package:flutter/material.dart';
import 'package:pointycastle/export.dart';

class AESHelper {
  final Key key;
  final IV iv;
  final Encrypter encrypter;

  AESHelper(String keyString)
      : key = Key.fromBase64(keyString), // Converte Base64 para Key
        iv = IV.allZerosOfLength(16),
        encrypter = Encrypter(AES(Key.fromBase64(keyString)));

  String encrypt(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    print("meu texto aqui: ${encrypted.base64}");
    return encrypted.base64;
  }

  String decrypt(String encryptedText) {
    final encrypted = Encrypted.fromBase64(encryptedText);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }
  // String encrypt(String plainText) {

  //   return
  // }
}

Key generateRandomKey(int length) {
  final random = Random.secure();
  final keyBytes = List<int>.generate(length, (_) => random.nextInt(256));
  return Key(Uint8List.fromList(keyBytes));
}

String generateRandomKeyAsBase64(int length) {
  final randomKey = generateRandomKey(length);
  return base64Encode(randomKey.bytes); // Converte a chave para Base64
}
