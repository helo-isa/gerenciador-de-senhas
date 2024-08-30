import 'dart:convert';
import 'package:crypto/crypto.dart';

String generateHash(String input) {
  final bytes = utf8.encode(input); // Converte para uma lista de bytes
  final digest = sha256.convert(bytes); // Gera o hash SHA-256
  return digest.toString(); // Converte o hash para uma string hexadecimal
}
