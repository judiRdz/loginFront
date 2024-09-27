import 'package:flutter/material.dart';
import 'dart:html';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthServices extends ChangeNotifier {
  final String _baseUrl =
      'judimoviles2.somee.com'; //_variable = variable privada
  final storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/Registrar');

    final resp = await http.post(
      //Es para hacer la solictud de registrar usuario
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData), //convierte el authData a formato json
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    } else {
      decodeResp['error']['Mensaje']; //TODO: Revisar si el backend manda si el error
    }
  }

  //TODO: Metodo para el login
  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.http(_baseUrl, '/api/Cuentas/Login');
    final resp = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: json.encode(authData),
    );

    final Map<String, dynamic> decodeResp = json.decode(resp.body);

    if (decodeResp.containsKey('token')) {
      await storage.write(key: 'token', value: decodeResp['token']);
      return null;
    } else {
      decodeResp['error']['message']; 
    }
  }

  Future<String> readToken()async{
    return await storage.read(key: 'token')??'';
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }
}
