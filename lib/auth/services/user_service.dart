import 'dart:convert';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:fastporte_app/auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class UserService extends ChangeNotifier {
  final String _baseUrlBack = 'localhost:8080';
  final storage = FlutterSecureStorage();

  Future<User> getUserById (String userId) async {
    final Uri url;

    if (globals.role == 'transportista'){
      url = Uri.http(_baseUrlBack, '/api/drivers/$userId');
    }else {
      url = Uri.http(_baseUrlBack, '/api/clients/$userId');
    }
    
    final token = await storage.read(key: 'token');
    final resp = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200){
      final userJson = json.decode(resp.body);
      final user = User.fromMap(userJson);

      return user;
    }else{
      throw Exception('Error al obtener el usuario');
    }
  }
}