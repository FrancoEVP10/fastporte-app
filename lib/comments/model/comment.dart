import 'dart:convert';
import 'package:fastporte_app/auth/model/user.dart';

class Comment {
    User client;
    String comment;
    User driver;
    int id;
    String star;

    Comment({
        required this.client,
        required this.comment,
        required this.driver,
        required this.id,
        required this.star,
    });

    Comment copyWith({
        User? client,
        String? comment,
        User? driver,
        int? id,
        String? star,
    }) => 
        Comment(
            client: client ?? this.client,
            comment: comment ?? this.comment,
            driver: driver ?? this.driver,
            id: id ?? this.id,
            star: star ?? this.star,
        );

    factory Comment.fromJson(String str) => Comment.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Comment.fromMap(Map<String, dynamic> json) => Comment(
        client: json["client"],
        comment: json["comment"],
        driver: json["driver"],
        id: json["id"],
        star: json["star"],
    );

    Map<String, dynamic> toMap() => {
        "client": client,
        "comment": comment,
        "driver": driver,
        "id": id,
        "star": star,
    };
}