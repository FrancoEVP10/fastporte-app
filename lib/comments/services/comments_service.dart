import 'dart:convert';
import 'package:fastporte_app/comments/model/comment.dart';
//import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class CommentsService extends ChangeNotifier {
  final String _baseUrlBack = 'localhost:8080';
  // final String _baseUrlBack = '192.168.0.112:8080'; // no me lo borren xd
  late Comment comment;
  bool isSaving = false;
  final storage = FlutterSecureStorage();

  Future<List<dynamic>> getCommentsByDriverId(String driverId) async {
    final Uri url = Uri.http(_baseUrlBack, '/api/comments/driver/$driverId');
    final token = await storage.read(key: 'token');

    final resp = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final commentsJson = jsonDecode(utf8.decode(resp.bodyBytes));
      //print(userJson);
      final comments = convertList(commentsJson);
      //print(contracts);
      return comments;
    } else {
      throw Exception('Error al obtener los comentarios ${resp.statusCode}');
    }

  }


  static List<dynamic> convertList<T>(List<dynamic> json) {
    List<dynamic> objects = [];
    for (var item in json) {
      //print(_fromJson(item));
      objects.add(_fromJson(item));
    }
    //print(objects);
    return objects;
  }

  static dynamic _fromJson(dynamic item) {
    //print(item.runtimeType);
    String jsonString = json.encode(item);
    dynamic object = json.decode(jsonString);
    //print(object);
    return object;

    // Add more type conversions as needed
    // else if (T == SomeOtherType) {
    //   return SomeOtherType.fromJson(item) as T;
    // }

    //throw Exception('Type conversion not implemented for type $T');
  }
}