import 'dart:convert';
import 'package:fastporte_app/auth/model/user.dart';

class Vehicle {
    String brand;
    String category;
    User driver;
    int id;
    String photoCar;
    int quantity;
    String typeCar;

    Vehicle({
        required this.brand,
        required this.category,
        required this.driver,
        required this.id,
        required this.photoCar,
        required this.quantity,
        required this.typeCar,
    });

    Vehicle copyWith({
        String? brand,
        String? category,
        User? driver,
        int? id,
        String? photoCar,
        int? quantity,
        String? typeCar,
    }) => 
        Vehicle(
            brand: brand ?? this.brand,
            category: category ?? this.category,
            driver: driver ?? this.driver,
            id: id ?? this.id,
            photoCar: photoCar ?? this.photoCar,
            quantity: quantity ?? this.quantity,
            typeCar: typeCar ?? this.typeCar,
        );

    factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        brand: json["brand"],
        category: json["category"],
        driver: User.fromMap(json["driver"]),
        id: json["id"],
        photoCar: json["photo_car"],
        quantity: json["quantity"],
        typeCar: json["type_car"],
    );

    Map<String, dynamic> toMap() => {
        "brand": brand,
        "category": category,
        "driver": driver,
        "id": id,
        "photo_car": photoCar,
        "quantity": quantity,
        "type_car": typeCar,
    };
}