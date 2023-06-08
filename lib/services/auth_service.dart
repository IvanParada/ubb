import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;


class AuthService extends ChangeNotifier{
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyAZs_EqCGSCaM822d3HZCiRrKwVdC8jYaA';

  final storage = const FlutterSecureStorage();

Future<String?> createUser(String nombre, String apellido, String email, String password) async {
  final Map<String, dynamic> authData = {
    'nombre': nombre,
    'apellido': apellido,
    'email': email,
    'password': password
  };

  final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

  final resp = await http.post(url, body: json.encode(authData));
  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('idToken')) {
    await storage.write(key: 'token', value: decodedResp['idToken']);

    // Concatenar nombre y apellido para establecer el displayName
    final displayName = '$nombre $apellido';
    await setDisplayName(displayName); // Agrega este método

    return null;
  } else {
    return decodedResp['error']['message'];
  }
}

  Future<String?> login(String email, String password) async {

    final Map<String, dynamic> authData = {

      'email':email,
      'password':password

    };
    final url = Uri.https(_baseUrl,'/v1/accounts:signInWithPassword',{
      'key':_firebaseToken
      });

  final resp = await http.post(url,body: json.encode(authData));
  final Map<String, dynamic> decodedResp = json.decode(resp.body);


 
  if(decodedResp.containsKey('idToken')){
    //token guardado
    await storage.write(key: 'token', value: decodedResp['idToken']);
    return null;
  }else{
    return decodedResp['error']['message'];
      }
  }


  Future<Map<String, dynamic>?> getUserData() async {
  final token = await readToken();
  if (token.isEmpty) {
    return null;
  }

  final url = Uri.https(_baseUrl, '/v1/accounts:lookup', {
    'key': _firebaseToken,
  });

  final payload = {
    'idToken': token,
  };

  final resp = await http.post(url, body: json.encode(payload));
  final Map<String, dynamic> decodedResp = json.decode(resp.body);

  if (decodedResp.containsKey('users')) {
    // Se espera que la respuesta contenga una lista de usuarios,
    // pero solo se asume un usuario en este caso
    final userData = decodedResp['users'][0];
    return userData;
  } else {
    return null;
  }
}


  Future logout() async {
    await storage.delete(key: 'token');
    return;

  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';


  }

  Future<void> setDisplayName(String displayName) async {
  final token = await readToken();
  if (token.isEmpty) {
    return;
  }

  final url = Uri.https(_baseUrl, '/v1/accounts:update', {'key': _firebaseToken});

  final payload = {
    'idToken': token,
    'displayName': displayName,
  };

  await http.post(url, body: json.encode(payload));
}


}