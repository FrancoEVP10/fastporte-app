import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:fastporte_app/auth/model/user.dart';

class Contract {
  int id;
  String subject;
  String from;
  String to;
  DateTime contractDate;
  String timeDeparture;
  String timeArrival;
  String amount;
  String quantity;
  String description;
  User client;
  User driver;
  bool visible;

  Contract({
    required this.id,
    required this.subject,
    required this.from,
    required this.to,
    required this.contractDate,
    required this.timeDeparture,
    required this.timeArrival,
    required this.amount,
    required this.quantity,
    required this.description,
    required this.client,
    required this.driver,
    required this.visible,
  });

  factory Contract.fromJson(String str) => Contract.fromMap(json.decode((str)));

  String toJson() => json.encode((toMap()));

  factory Contract.fromMap(Map<String, dynamic> json) => Contract(
        id: json["id"],
        subject: json["subject"],
        from: json["from"],
        to: json["to"],
        contractDate: DateTime.parse(json["contractDate"]),
        timeDeparture: json["timeDeparture"],
        timeArrival: json["timeArrival"],
        amount: json["amount"],
        quantity: json["quantity"],
        description: json["description"],
        client: User.fromMap(json["client"]),
        driver: User.fromMap(json["driver"]),
        visible: json["visible"],
  );

  Map<String, dynamic> toMap() => {
        "id": id,
        "subject": subject,
        "from": from,
        "to": to,
        "contractDate": contractDate.toIso8601String(),
        "timeDeparture": timeDeparture,
        "timeArrival": timeArrival,
        "amount": amount,
        "quantity": quantity,
        "description": description,
        "client": client,
        "driver": driver,
        "visible": visible,
  };

  Contract copy() => Contract(
        id: id,
        subject: subject,
        from: from,
        to: to,
        contractDate: contractDate,
        timeDeparture: timeDeparture,
        timeArrival: timeArrival,
        amount: amount,
        quantity: quantity,
        description: description,
        client: client,
        driver: driver,
        visible: visible,
  );

}

Contract createFakeContract() {
  final faker = Faker();

  return Contract(
    id: faker.randomGenerator.integer(99999),
    subject: faker.lorem.word(),
    from: faker.address.city(),
    to: faker.address.city(),
    contractDate: faker.date.dateTime(),
    timeDeparture: faker.date.justTime(),
    timeArrival: faker.date.justTime(),
    amount: faker.randomGenerator.integer(4000).toString(),
    quantity: faker.randomGenerator.integer(99).toString(),
    description: faker.lorem.sentence(),
    client: createFakeUser(),
    driver: createFakeUser(),
    visible: faker.randomGenerator.boolean(),
  );
}