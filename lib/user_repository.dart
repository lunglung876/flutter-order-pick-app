import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<String> login({
    @required String username,
    @required String password,
  }) async {
    final uri = Uri.parse('https://hbx.com/login_check');
    var request = new http.MultipartRequest("POST", uri);
    request.headers.addAll({"Accept": "application/json"});
    request.fields['_username'] = '';
    request.fields['_password'] = '';
    var response = await request.send();
    if (response.statusCode == 200) print('Uploaded!');
    debugPrint(await response.stream.bytesToString());

    return 'token';
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}