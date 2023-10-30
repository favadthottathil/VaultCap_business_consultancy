import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptData {
 static String enencryptData(String data, String key) {
    final keyEncrypter = encrypt.Key.fromUtf8(key);
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(keyEncrypter));

    final encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }
}
