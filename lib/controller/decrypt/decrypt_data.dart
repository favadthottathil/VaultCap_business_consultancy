import 'dart:developer';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart' as encrypt;

decrypedData(String encrypedData, encrypt.Key key) {
  final encrypter = encrypt.Encrypter(encrypt.AES(key));

  final staticIv = encrypt.IV.fromUtf8('taxverse');
  final encrypted = encrypt.Encrypted.fromBase64(encrypedData);

  print(encrypted);

  final decrypted = encrypter.decrypt(encrypted, iv: staticIv);

  log('$decrypted hellloooooooooo');
  return decrypted;
}

encrypt.Key generateKey() {
  final key = encrypt.Key.fromUtf8('0123456789abcdef0123456789abcdef');
  return key;
}

List<int> decryptBytes(Uint8List encryptedBytes) {
  final key = generateKey();
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final staticIV = encrypt.IV.fromUtf8('taxverse');
  final decryptedBytes = encrypter.decryptBytes(encrypt.Encrypted(encryptedBytes), iv: staticIV);
  return decryptedBytes;
}
