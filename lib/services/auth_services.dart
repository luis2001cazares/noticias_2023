import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'loginpruebalc.somee.com';
  final storage = new FlutterSecureStorage();
//ENDPOINT PARA CREAR UN NUEVO USUARIO
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/registrar');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else if (decodedResp.containsKey('error') &&
        decodedResp['error'] is Map<String, dynamic> &&
        decodedResp['error'].containsKey('message')) {
      return decodedResp['error']['message'];
    } else {
      return 'Error desconocido al registrar usuario';
    }
  }
//ENDPOINT PARA INICIAR SESIÓN
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final url = Uri.http(_baseUrl, '/api/Cuentas/Login');

    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else if (decodedResp.containsKey('error') &&
        decodedResp['error'] is Map<String, dynamic> &&
        decodedResp['error'].containsKey('message')) {
      return decodedResp['error']['message'];
    } else {
      return 'Error desconocido al iniciar sesión';
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

