import 'dart:convert';

class User {
  DateTime birthdate;
  String description;
  String email;
  String id;
  String lastname;
  String name;
  String phone;
  String photo;
  String region;
  String username;

  User({
    required this.birthdate,
    required this.description,
    required this.email,
    required this.id,
    required this.lastname,
    required this.name,
    required this.phone,
    required this.photo,
    required this.region,
    required this.username,
  });

  factory User.fromJson(String str) => User.fromMap(json.decode((str)));

  String toJson() => json.encode((toMap()));

  factory User.fromMap(Map<String, dynamic> json) => User(
        birthdate: DateTime.parse(json["birthdate"]),
        description: json["description"],
        email: json["email"],
        id: json["id"],
        lastname: json["lastname"],
        name: json["name"],
        phone: json["phone"],
        photo: json["photo"],
        region: json["region"],
        username: json["username"],
      );

  Map<String, dynamic> toMap() => {
        "birthdate": birthdate.toIso8601String(),
        "description": description,
        "email": email,
        "id": id,
        "lastname": lastname,
        "name": name,
        "phone": phone,
        "photo": photo,
        "region": region,
        "username": username,
      };
  

  User copy() => User(
      birthdate: birthdate,
      description: description,
      email: email,
      id: id,
      lastname: lastname,
      name: name,
      phone: phone,
      photo: photo,
      region: region,
      username: username);
}
