import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepository {
  static FlutterSecureStorage storage;
  static const tokenStorageKey = 'jwtToken';

  UserRepository() {
    storage = new FlutterSecureStorage();
  }

  Future<void> deleteToken() async {
    await storage.delete(key: tokenStorageKey);

    return;
  }

  Future<void> persistToken(String token) async {
    await storage.write(key: tokenStorageKey, value: token);

    return;
  }

  Future<String> getToken() async {
    return await storage.read(key: tokenStorageKey);
  }

  Future<bool> hasToken() async {
    var token = await storage.read(key: tokenStorageKey);

    return token != null;
  }
}
