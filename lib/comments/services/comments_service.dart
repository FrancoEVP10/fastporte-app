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


    Future<Comment> createComment(Comment comment) async {
    final url = Uri.http(_baseUrlBack, '/api/comments/add/${comment.client.id}/${comment.driver.id}');
    //final url = Uri.https(_baseUrlBack, '/api/clients');
    final body = comment.toJson();
    final token = await storage.read(key: 'token');
    final resp = await http.post(
      url,
      body: jsonEncode(body),
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    // ignore: unused_local_variable
    final decodedData = json.decode(resp.body);

    return comment;
  }

  Future<List<Comment>> getCommentsByDriverId(String driverId) async {
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
      return [];
    }

  }

  static List<Comment> convertList<T>(List<dynamic> json) {
    List<Comment> objects = [];
    for (var item in json) {
      objects.add(Comment.fromMap(item));
    }
    return objects;
  }

    Future<List<dynamic>> getAllComments() async {
    final Uri url = Uri.http(_baseUrlBack, '/api/comments');
    final token = await storage.read(key: 'token');

    final resp = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final vehicleJson = jsonDecode(utf8.decode(resp.bodyBytes));
      //print(userJson);
      final vehicles = convertList(vehicleJson);
      //print(contracts);
      return vehicles;
    } else {
      throw Exception('Error al obtener comentarios ${resp.statusCode}');
    }
  }

  Future<int> getSize() async {
    final list = getAllComments();

    return list.then((lista){
      return lista.length;
    });
  }

}