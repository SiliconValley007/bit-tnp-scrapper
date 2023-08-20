import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:tnp_scanner/manager/local_storage_manager.dart';

abstract class Network {
  static Future<String?> getCookieFromTnp(
      {required String username, required String password}) async {
    final Uri url = Uri.parse('https://tp.bitmesra.co.in/login.html');
    final response = await http.post(
      url,
      body: {
        'identity': username,
        'password': password,
      },
      headers: {
        'User-Agent':
            "Mozilla/5.0 (iPad; CPU OS 12_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148", // Replace with your desired User-Agent
      },
    );
    log(response.toString());
    final cookies = response.headers['set-cookie'];
    log('Headers');
    log(cookies.toString());
    if (cookies != null) {
      final cookie = cookies.split(';').first;
      return cookie;
    }
    return null;
  }

  static Future<int?> login(
      {required String username, required String password}) async {
    final String? cookie = await getCookieFromTnp(
      username: username,
      password: password,
    );
    if (cookie == null) {
      return null;
    }
    LocalStorage.saveCookie(cookie);
    return 200;
  }
}
