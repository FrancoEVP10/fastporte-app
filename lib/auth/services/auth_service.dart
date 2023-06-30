import 'dart:convert';
import 'package:fastporte_app/globals.dart' as globals;
//import 'package:fastporte_app/auth/model/user.dart';
import 'package:fastporte_app/auth/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'user_service.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrlBack = 'localhost:8080';
  // final String _baseUrlBack = '192.168.0.112:8080'; // no me lo borren xd
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyDnWZsX3Fv1M9cUw6QeR1D337mZl5FNjlI';
  final userService = UserService();
  final storage = FlutterSecureStorage();

  // Si retornamos algo, es un error, si no, todo bien!
  Future<String?> createUserFirebase(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp['localId'] == null) {
      Fluttertoast.showToast(
          msg: "El correo ingresado ya existe",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0);
    } else {
      globals.localId = decodedResp['localId'];
    }

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      // decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String> createUserBackend(User user) async {
    final url = Uri.http(_baseUrlBack, '/api/clients');
    //final url = Uri.https(_baseUrlBack, '/api/clients');
    final token = await storage.read(key: 'token');
    final resp = await http.post(
      url,
      body: user.toJson(),
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    // ignore: unused_local_variable
    final decodedData = json.decode(resp.body);

    return user.id;
  }

  Future<String> createUserDriverBackend(User user) async {
    final url = Uri.http(_baseUrlBack, '/api/drivers');
    //final url = Uri.https(_baseUrlBack, '/api/clients');
    final token = await storage.read(key: 'token');
    final resp = await http.post(
      url,
      body: user.toJson(),
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    // ignore: unused_local_variable
    final decodedData = json.decode(resp.body);

    return user.id;
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Token hay que guardarlo en un lugar seguro
      // decodedResp['idToken'];
      // localid (para el id del back)
      globals.localId = decodedResp['localId'];
      try {
        await getUserById(globals.localId, decodedResp['idToken']);
      } catch (e) {
        return 'El tipo de usuario no es correcto';
      }

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

  Future<User> getUserById(String userId, String? token) async {
    final Uri url;

    if (globals.role == 'transportista') {
      url = Uri.http(_baseUrlBack, '/api/drivers/$userId');
    } else {
      url = Uri.http(_baseUrlBack, '/api/clients/$userId');
    }


    final resp = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final userJson = jsonDecode(utf8.decode(resp.bodyBytes));
      final user = User.fromMap(userJson);

      return user;
    } else {
      throw Exception('Error al obtener el usuario ${resp.statusCode}');
    }
  }
}
