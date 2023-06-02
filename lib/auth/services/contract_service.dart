import 'dart:convert';
import 'package:fastporte_app/auth/model/contract.dart';
import 'package:fastporte_app/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ContractService extends ChangeNotifier {
  //static String _baseUrlBack = 'localhost:8080';
  late Contract contract;

  bool isSaving = false;

  static Future<List<dynamic>> getContracts() async {
      var storage = FlutterSecureStorage();
    print("aqui");
    final Uri url;
    const String _baseUrlBack = 'localhost:8080';

    if (globals.role == 'transportista') {
      url = Uri.http(_baseUrlBack, '/api/contracts');
    } else {
      url = Uri.http(_baseUrlBack, '/api/contracts');
    }

    final token = await storage.read(key: 'token');
    //const token =
        //"eyJhbGciOiJSUzI1NiIsImtpZCI6IjJkM2E0YTllYjY0OTk0YzUxM2YyYzhlMGMwMTY1MzEzN2U5NTg3Y2EiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vZmFzdHBvcnRlLWFwcCIsImF1ZCI6ImZhc3Rwb3J0ZS1hcHAiLCJhdXRoX3RpbWUiOjE2ODU2NDYzMDUsInVzZXJfaWQiOiJGVW5kNUY3RlhFU2szRjd6aHlWSHhRWDU2RGwyIiwic3ViIjoiRlVuZDVGN0ZYRVNrM0Y3emh5Vkh4UVg1NkRsMiIsImlhdCI6MTY4NTY0NjMwNSwiZXhwIjoxNjg1NjQ5OTA1LCJlbWFpbCI6Iml2YW5tb3Jhbi5kZXZAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOmZhbHNlLCJmaXJlYmFzZSI6eyJpZGVudGl0aWVzIjp7ImVtYWlsIjpbIml2YW5tb3Jhbi5kZXZAZ21haWwuY29tIl19LCJzaWduX2luX3Byb3ZpZGVyIjoicGFzc3dvcmQifX0.TzI-2SOVvvzUbCdXxPFvmjKqITZyBMH-DXY64SKBfgyjNy7V4LQkw5AGcW4wOlwwRON81DoK6DmD2ynGg-KJ2YcbfT6p4GDvAuE2ARcxaoipyRrQOelaWG3JIm3o3AVUeIBETsy21l14NO870iMLegf471gG-rM3zz6MVxxN1ZfPNRZ5RkqeNzlrcowoNxelHTdTHVHXI0mzftheWCsigdwKP_aHjDo4IleOdPngNos-7ucP0laFbJhZq2_bcQQYUYA11ki1aAKhbp3IM9clT2_ZUUXY_uJEYBku2p2SSvgpY-9s4evgD7zH7_x3ta3Xu7rH80a4kMS1faNptBUMUw";
    final resp = await http.get(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    if (resp.statusCode == 200) {
      final userJson = jsonDecode(utf8.decode(resp.bodyBytes));
      //print(userJson);
      final contracts = convertList(userJson);
      //print(contracts);
      return contracts;
    } else {
      throw Exception('Error al obtener el usuario ${resp.statusCode}');
    }
  }

  /*
  Future<Contract> updateUser(User user) async {
    final Uri url;
    if (globals.role == 'transportista') {
      url = Uri.http(_baseUrlBack, '/api/contracts/${user.id}');
    } else {
      url = Uri.http(_baseUrlBack, '/api/contracts/${user.id}');
    }
    final token = await storage.read(key: 'token');
    final resp = await http.put(
      url,
      headers: {
        'content-type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: user.toJson(),
    );
    if (resp.statusCode == 200) {
      return user.id;
    } else {
      throw Exception('Error al obtener el usuario');
    }
  }
  */

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
