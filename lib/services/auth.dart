import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productos_app/dotenv.dart';

class AuthService extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url = Uri.https(host, '/v1/accounts:signUp', {'key': fapi});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    // decodedResp.containsKey('idToken') ? null : decodedResp['error']['message'];
    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        Uri.https(host, '/v1/accounts:signInWithPassword', {'key': fapi});
    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    // decodedResp.containsKey('idToken') ? null : decodedResp['error']['message'];
    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
